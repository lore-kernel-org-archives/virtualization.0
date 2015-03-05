From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio_blk: fix comment for virtio 1.0
Date: Thu, 5 Mar 2015 09:40:19 +0100
Message-ID: <20150305084019.GB11474@redhat.com>
References: <1425192883-5930-1-git-send-email-mst@redhat.com>
	<1425192883-5930-3-git-send-email-mst@redhat.com>
	<871tl8l0eu.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <871tl8l0eu.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 02, 2015 at 10:45:37AM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > Fix up comment to match virtio 1.0 logic:
> > virtio_blk_outhdr isn't the first elements anymore,
> > the only requirement is that it comes first in
> > the s/g list.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Thanks, both applied.
> 
> Cheers,
> Rusty.

Hmm, I don't see them in your virtio-next tree.
Did I miss something?
I know these are just headers but it's in UAPI
so I'd like to make them correct ASAP.
