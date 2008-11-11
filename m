From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Tue, 11 Nov 2008 10:48:43 +1030
Message-ID: <200811111048.45242.rusty@rustcorp.com.au>
References: <20081106154351.GA30459@kroah.com>
	<20081107061700.GD3860@kroah.com> <4913F2AA.90405@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8291497764579934243=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4913F2AA.90405@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhao, Yu" <yu.zhao@intel.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, Leonid.Grossman@neterion.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <anthony@codemonkey.ws>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

--===============8291497764579934243==
Content-Type: multipart/alternative;
  boundary="Boundary-00=_l9MGJBg4dTg2PKW"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_l9MGJBg4dTg2PKW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Friday 07 November 2008 18:17:54 Zhao, Yu wrote:
> Greg KH wrote:
> > On Thu, Nov 06, 2008 at 04:40:21PM -0600, Anthony Liguori wrote:
> >> Greg KH wrote:
> >>> On Thu, Nov 06, 2008 at 10:47:41AM -0700, Matthew Wilcox wrote:
> >>>> I don't think we really know what the One True Usage model is for VF
> >>>> devices.  Chris Wright has some ideas, I have some ideas and Yu Zhao
> >>>> has some ideas.  I bet there's other people who have other ideas too.
> >>>
> >>> I'd love to hear those ideas.
> >>
> >> We've been talking about avoiding hardware passthrough entirely and
> >> just backing a virtio-net backend driver by a dedicated VF in the
> >> host.  That avoids a huge amount of guest-facing complexity, let's
> >> migration Just Work, and should give the same level of performance.
>
> This can be commonly used not only with VF -- devices that have multiple
> DMA queues (e.g., Intel VMDq, Neterion Xframe) and even traditional
> devices can also take the advantage of this.
>
> CC Rusty Russel in case he has more comments.

Yes, even dumb devices could use this mechanism if you wanted to bind an 
entire device solely to one guest.

We don't have network infrastructure for this today, but my thought was to do 
something in dev_alloc_skb and dev_kfree_skb et al.

Cheers,
Rusty.

--Boundary-00=_l9MGJBg4dTg2PKW
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'DejaVu Sans Mon'; font-size:9pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On Friday 07 November 2008 18:17:54 Zhao, Yu wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Greg KH wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; On Thu, Nov 06, 2008 at 04:40:21PM -0600, Anthony Liguori wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; Greg KH wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; On Thu, Nov 06, 2008 at 10:47:41AM -0700, Matthew Wilcox wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; I don't think we really know what the One True Usage model is for VF</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; devices.  Chris Wright has some ideas, I have some ideas and Yu Zhao</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; has some ideas.  I bet there's other people who have other ideas too.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; I'd love to hear those ideas.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; We've been talking about avoiding hardware passthrough entirely and</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; just backing a virtio-net backend driver by a dedicated VF in the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; host.  That avoids a huge amount of guest-facing complexity, let's</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; migration Just Work, and should give the same level of performance.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; This can be commonly used not only with VF -- devices that have multiple</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; DMA queues (e.g., Intel VMDq, Neterion Xframe) and even traditional</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; devices can also take the advantage of this.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; CC Rusty Russel in case he has more comments.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Yes, even dumb devices could use this mechanism if you wanted to bind an entire device solely to one guest.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">We don't have network infrastructure for this today, but my thought was to do something in dev_alloc_skb and dev_kfree_skb et al.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Cheers,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Rusty.</p></body></html>
--Boundary-00=_l9MGJBg4dTg2PKW--

--===============8291497764579934243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============8291497764579934243==--
