From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] vhost: fixes
Date: Wed, 6 May 2020 05:39:55 -0400
Message-ID: <20200506053948-mutt-send-email-mst@kernel.org>
References: <20200504081540-mutt-send-email-mst@kernel.org>
 <AM6PR08MB40696EFF8BE389C134AC04F6F7A40@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <20200506031918-mutt-send-email-mst@kernel.org>
 <20200506092546.o6prnn4d66tavmjl@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200506092546.o6prnn4d66tavmjl@steredhat>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Justin He <Justin.He@arm.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ldigby@redhat.com" <ldigby@redhat.com>, "n.b@live.com" <n.b@live.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 06, 2020 at 11:25:46AM +0200, Stefano Garzarella wrote:
> On Wed, May 06, 2020 at 03:19:55AM -0400, Michael S. Tsirkin wrote:
> > On Wed, May 06, 2020 at 03:28:47AM +0000, Justin He wrote:
> > > Hi Michael
> > > 
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Monday, May 4, 2020 8:16 PM
> > > > To: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Cc: kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Justin He
> > > > <Justin.He@arm.com>; ldigby@redhat.com; mst@redhat.com; n.b@live.com;
> > > > stefanha@redhat.com
> > > > Subject: [GIT PULL] vhost: fixes
> > > >
> > > > The following changes since commit
> > > > 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:
> > > >
> > > >   Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> > > >
> > > > for you to fetch changes up to
> > > > 0b841030625cde5f784dd62aec72d6a766faae70:
> > > >
> > > >   vhost: vsock: kick send_pkt worker once device is started (2020-05-02
> > > > 10:28:21 -0400)
> > > >
> > > > ----------------------------------------------------------------
> > > > virtio: fixes
> > > >
> > > > A couple of bug fixes.
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > >
> > > > ----------------------------------------------------------------
> > > > Jia He (1):
> > > >       vhost: vsock: kick send_pkt worker once device is started
> > > 
> > > Should this fix also be CC-ed to stable? Sorry I forgot to cc it to stable.
> > > 
> > > --
> > > Cheers,
> > > Justin (Jia He)
> > 
> > 
> > Go ahead, though recently just including Fixes seems to be enough.
> > 
> 
> The following patch Justin refers to does not contain the "Fixes:" tag:
> 
> 0b841030625c vhost: vsock: kick send_pkt worker once device is started
> 
> 
> I think we should merge it on stable branches, so if needed, I can backport
> and send it.
> 
> Stefano

Go ahead.

-- 
MST
