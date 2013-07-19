From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH V2 0/2] [BUGFIX] virtio/console: Fix two bugs of
	splice_write
Date: Fri, 19 Jul 2013 15:35:43 +0530
Message-ID: <20130719100543.GM3087@amit-x200.redhat.com>
References: <20130719091951.9698.95194.stgit@yunodevel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130719091951.9698.95194.stgit@yunodevel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, yrl.pp-manager.tt@hitachi.com, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 19 Jul 2013 [18:19:51], Yoshihiro YUNOMAE wrote:
> Hi,
> 
> This patch set fixes two bugs of splice_write in the virtio-console driver.
> 
> [BUG1] Although pipe->nrbufs is empty, the driver tries to do splice_write.
>        => This induces oops in sg_init_table().
> 
> [BUG2] No lock for competition of splice_write.
>        => This induces oops in splice_from_pipe_feed() by bug of any user
>           application.
> 
> These reports are written in each patch.
> 
> Changes in V2:
> - Fix a locking problem for error
> 
> Thanks!

Reviewed-by: Amit Shah <amit.shah@redhat.com>

For the patches to be picked up in the stable trees, you need to
include CC: <stable@vger.kernel.org> in the sign-off area of the
patches, just cc'ing in the patch posting doesn't help.  See
Documentation/stable_kernel_rules.txt.

Can you submit a v3 with that change, and also add my reviewed-by
line?

		Amit
