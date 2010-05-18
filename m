From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] fix a code style in drivers/char/virtio_console.c
Date: Tue, 18 May 2010 12:02:41 +0530
Message-ID: <20100518063241.GB27262__16818.6938194141$1274164302$gmane$org@amit-laptop.redhat.com>
References: <AANLkTilW8zZxCOrdiefZ4ZtixprI58LzDZ6Cz03z4lFk@mail.gmail.com>
	<20100518052230.GA1706@amit-laptop.redhat.com>
	<AANLkTimXLkzb-CyhbkOaubAOiSsIkGKW0y5Cblrwfvst@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimXLkzb-CyhbkOaubAOiSsIkGKW0y5Cblrwfvst@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Liu <lingjiujianke@gmail.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On (Tue) May 18 2010 [13:41:29], Steven Liu wrote:
> Hi, Amit,
> 
>     if 'err' initialised in this path, it needn't do err = -ENOMEM
> after,isn't it?

What I mean is if we later add some code that just does:

	if (err)
		goto fail;

then 'ret' can be -ENOMEM, as it was initialised to, which would be
fine. But if a later patch adds something like:

+	ret = -EIO;
+	err = ...
+	if (err)
+		goto fail;
+
	err = ...
	if (err)
		goto fail;

In this case, the 2nd if() would now return EIO instead of ENOMEM as
earlier.

Also, this style of coding can prevent uninitialised usage of 'ret', eg:


	int ret;

	if (err)
		goto fail;

fail:
	return ret;

In this case, the compiler will warn about 'ret' being used
uninitialised.

This is just a coding style issue. I had initially coded it the way your
patch does, but Rusty asked me to change that and I like this new style
better: there's less scope for surprises.

		Amit
