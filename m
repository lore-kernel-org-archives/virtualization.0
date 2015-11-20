From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
	target
Date: Thu, 19 Nov 2015 21:33:44 -0800
Message-ID: <1447997624.3473.6.camel@hasee>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<20151120051645.GB19405@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151120051645.GB19405@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: qemu-devel@nongnu.org, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2015-11-20 at 06:16 +0100, Christoph Hellwig wrote:
> Thanks Ming,
> 
> from a first quick view this looks great.  I'll look over it in a bit
> more detail once I get a bit more time.

Thanks to CC Nic :-)

But funny, I double-checked bash history. I actually CCed Nic.
Don't know why it's lost.

mlin@ssi:~$ history |grep "nab"
 1861  git send-email --from "Ming Lin <mlin@kernel.org>" --to
"linux-nvme@lists.infradead.org"  --cc "qemu-devel@nongnu.org" --cc
"virtualization@lists.linux-foundation.org" --cc "Christoph Hellwig
<hch@lst.de>" --cc "Nicholas A. Bellinger <nab@linux-iscsi.org>"
--compose ~/patches/*.patch
