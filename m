From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 RFC] virtio-pci: flexible configuration layout
Date: Mon, 5 Dec 2011 22:20:19 +0200
Message-ID: <20111205202019.GB18939@redhat.com>
References: <20111114181854.GA24953@redhat.com>
	<20111205111605.73b60faa@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111205111605.73b60faa@jbarnes-desktop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 05, 2011 at 11:16:05AM -0800, Jesse Barnes wrote:
> On Mon, 14 Nov 2011 20:18:55 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Add a flexible mechanism to specify virtio configuration layout, using
> > pci vendor-specific capability.  A separate capability is used for each
> > of common, device specific and data-path accesses.
> > 
> > Warning: compiled only.
> > This patch also needs to be split up, pci_iomap changes
> > also need arch updates for non-x86.
> > There might also be more spec changes.
> > 
> > Posting here for early feedback, and to allow Sasha to
> > proceed with his "kvm tool" work.
> > 
> > Changes from v1:
> > Updated to match v3 of the spec, see:
> > 	Subject: [PATCHv3 RFC] virtio-spec: flexible configuration layout
> > 	Message-ID: <20111110122436.GA13144@redhat.com>
> > 	In-Reply-To: <20111109195901.GA28155@redhat.com>
> 
> Looks like this conflicts with your other iomap changes... I didn't
> check your latest tree; do you just add another patch on top for the
> virtio changes now?
> 
> Thanks,

Yes. Rusty asked for more changes so that isn't yet pushed.

> -- 
> Jesse Barnes, Intel Open Source Technology Center
