From: Andy King <acking@vmware.com>
Subject: Re: [PATCH 1/1] VSOCK: Introduce VM Sockets
Date: Mon, 18 Feb 2013 09:09:23 -0800 (PST)
Message-ID: <1877909883.2079524.1361207363932.JavaMail.root__13533.4526341923$1361207400$gmane$org@vmware.com>
References: <1360196636-9357-1-git-send-email-acking@vmware.com>
	<1360196636-9357-2-git-send-email-acking@vmware.com>
	<CA+1xoqfWGUuFjruFk1UV1BAXwzZvX4_i0MShQEpsq69B6P9ieg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+1xoqfWGUuFjruFk1UV1BAXwzZvX4_i0MShQEpsq69B6P9ieg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, gregkh@linuxfoundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Hi Sasha,

> > + * Specifically, we initialize the vsock_bind_table array to a size of
> > + * VSOCK_HASH_SIZE + 1 so that vsock_bind_table[0] through
...
> Why isn't it using the kernel's linux/hashtable.h?

Gah, that's a leftover from when it was platform independent :/  I have a
patch lying around to address this, once we have some more fixes batched
up I'll send it out.  Sorry about that!

Thanks!
- Andy
