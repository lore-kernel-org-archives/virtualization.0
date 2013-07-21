From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] virtio: console: fix error handling for
	debugfs_create_dir()
Date: Mon, 22 Jul 2013 01:33:54 +0300
Message-ID: <20130721223354.GH5585@mwanda>
References: <20130719055049.GD9729@elgon.mountain>
	<201307191228.41794.arnd@arndb.de> <20130720215048.GD5636@mwanda>
	<201307211136.25989.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201307211136.25989.arnd@arndb.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> I don't see where that oops would happen. In the code I'm looking at,
> all uses of ->debugfs_dir only ever get passed into other debugfs
> functions that are stubbed out to empty inline functions.
> 
> It's not the most obvious interface design, but this all seems intentional
> and correct to me.

Ah.  Ok.  You're right.

regards,
dan carpenter
