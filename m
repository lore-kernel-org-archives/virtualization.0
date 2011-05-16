From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 14/18] virtio: add api for delayed callbacks
Date: Mon, 16 May 2011 16:43:21 +0930
Message-ID: <87boz3dsoe.fsf__1303.56381782821$1305600645$gmane$org@rustcorp.com.au>
References: <cover.1304541918.git.mst@redhat.com>
	<64d47c628b3fdc0ac156aed4be182933d8bcc0db.1304541919.git.mst@redhat.com>
	<871v08h0vm.fsf@rustcorp.com.au>
	<20110515124818.GD24932@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110515124818.GD24932@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 15 May 2011 15:48:18 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, May 09, 2011 at 03:27:33PM +0930, Rusty Russell wrote:
> > On Wed, 4 May 2011 23:52:33 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > Add an API that tells the other side that callbacks
> > > should be delayed until a lot of work has been done.
> > > Implement using the new used_event feature.
> > 
> > Since you're going to add a capacity query anyway, why not add the
> > threshold argument here?
> 
> I thought that if we keep the API kind of generic
> there might be more of a chance that future transports
> will be able to implement it. For example, with an
> old host we can't commit to a specific index.

No, it's always a hint anyway: you can be notified before the threshold
is reached.  But best make it explicit I think.

Cheers,
Rusty.
