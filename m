From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH 4/9] virtio-serial: Handle
	scatter-gather buffers for control messages
Date: Tue, 23 Mar 2010 21:45:08 +0530
Message-ID: <20100323161508.GF3080@amit-x200.redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-2-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-3-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-4-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-5-git-send-email-amit.shah@redhat.com>
	<4BA47C02.3000105@redhat.com>
	<20100322051802.GE24577@amit-x200.redhat.com>
	<20100323155126.GA25772@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100323155126.GA25772@redhat.com>
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
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>, quintela@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Mar 23 2010 [17:51:26], Michael S. Tsirkin wrote:
> On Mon, Mar 22, 2010 at 10:48:02AM +0530, Amit Shah wrote:
> > On (Sat) Mar 20 2010 [09:40:50], Avi Kivity wrote:
> > > On 03/19/2010 01:58 PM, Amit Shah wrote:
> > >> +
> > >> +        offset = 0;
> > >> +        for (i = 0; i<  elem.out_num; i++) {
> > >> +            memcpy(buf + offset, elem.out_sg[i].iov_base,
> > >> +                   elem.out_sg[i].iov_len);
> > >> +            offset += elem.out_sg[i].iov_len;
> > >> +        }
> > >> +        len = cur_len;
> > >> +
> > >> +        handle_control_message(vser, buf, len);
> > >> +        virtqueue_push(vq,&elem, len);
> > >> +    }
> > >> +    if (len) {
> > >> +        qemu_free(buf);
> > >>       }
> > >>       virtio_notify(vdev, vq);
> > >>   }
> > >
> > > Isn't there some virtio function to linearize requests?
> > 
> > I don't see one.
> 
> virtio-net has iov_fill. Reuse it?

Hm, yeah. Any ideas on how to share it? Put it in some common file?

Just copying it seems good for now..

		Amit
