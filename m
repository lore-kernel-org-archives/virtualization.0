From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio-pci new configuration proposal
Date: Fri, 4 Nov 2011 15:51:15 +0200
Message-ID: <20111104135113.GA24452__18015.9445888878$1320414678$gmane$org@redhat.com>
References: <1320259767.22582.2.camel@lappy> <8762j2t19l.fsf@rustcorp.com.au>
	<1320309203.29407.1.camel@lappy> <87lirwrzlg.fsf@rustcorp.com.au>
	<20111104114033.GA21308@redhat.com> <1320409939.3334.6.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320409939.3334.6.camel@lappy>
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
Cc: Anthony Liguori <anthony@codemonkey.ws>, linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 04, 2011 at 02:32:19PM +0200, Sasha Levin wrote:
> On Fri, 2011-11-04 at 13:40 +0200, Michael S. Tsirkin wrote:
> > On Fri, Nov 04, 2011 at 08:14:43PM +1030, Rusty Russell wrote:
> > > > > 3) If we're changing the queue layout, it's a chance to fix a
> > > > >    longstanding bug: let the guest notify the host of preferred
> > > > >    queue size and alignment.
> > > > 
> > > > Yup, we can do that.
> > 
> > We don't need to change all of layout for that - just add another field
> > in the common config structure to supply the alignment.
> 
> How would you do it without changing the layout? Add another optional
> field at the end which will shift offsets based on whether the host and
> guest support this new feature or not?
> 
> This leads to 3 different things which now shift config offsets around.

No. Just put the field at offset 24 from the offset specified
by VIRTIO_PCI_CAP_COMMON_CFG.

> As you said, the PCI cap list was introduced both to save space (which
> is not the motivation here), and because it's a very efficient

It's actually pretty inefficient - there's an overhead of 3 bytes for
each vendor specific option.

> and easy way to manage optional features without requiring tricks
> which move offsets around like we do now.

Tricks with offsets only appeared because we had datapath, device
specific and common config in the same place.
feature list isn't needed to fix that.

> -- 
> 
> Sasha.
