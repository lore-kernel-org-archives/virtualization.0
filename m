From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio-net: fix data corruption with OOM
Date: Mon, 26 Oct 2009 18:27:20 -0700 (PDT)
Message-ID: <20091026.182720.81248604.davem__43131.5638161779$1256606881$gmane$org@davemloft.net>
References: <20091025170340.GA22099@redhat.com>
	<200910261211.52148.rusty@rustcorp.com.au>
	<20091026090713.GA23510@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091026090713.GA23510@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 26 Oct 2009 11:07:13 +0200

> Another, and hopefully the last, note, is that
> git-am can only handle Subject/From lines
> at the beginning of the message.
> So git style of the mail would be
 ...
> I think it's weird. We could invent some kind of separator
> that would make git-am accept Subject/From/Date lines in
> the middle of the message, so that discussion can come before
> the description. Worth it?

There is no need for this.  patchwork handles this situation perfectly
and this is what I use to apply all networking patches.

Anything in a reply to a patch that looks like a signoff or ACK,
patchwork adds to the commit message in the mbox blob it spits out for
me.
