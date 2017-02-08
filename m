From: Jason He via Virtualization <virtualization@lists.linux-foundation.org>
Subject: FW: Question about /patch/9251925/
Date: Wed, 8 Feb 2017 16:25:07 +0800
Message-ID: <93c4337b233133a7b649883a96d88924@mail.gmail.com>
Reply-To: Jason He <jason.he@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6427398547118528109=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
References: b554ef600b74602795137947d050c4c2@mail.gmail.com
In-Reply-To: b554ef600b74602795137947d050c4c2@mail.gmail.com
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============6427398547118528109==
Content-Type: multipart/alternative; boundary=f403045e1e1842c5d70548009af2

--f403045e1e1842c5d70548009af2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michael,



Excuse me for disturbing you with this letter!



I=E2=80=99m using linux 4.7.2 virtio driver + X86 64 + smart nic to validat=
e PF and
VF virtio performance.



The VF=E2=80=99s performance is >1Mpps, but the PF=E2=80=99s performance is=
 only  500Kpps
even if using 8 virtio queues.



So I reviewed virtio iommu patch in detail. I worry  dma map/unmap cost
many cycles.  Do you have any suggestion? Thanks a lot!



Today I also reviewed Intel 40G driver of linux 4.7.2 and compared with
virtio net driver. I focus on buffer management and list the difference in
below table:





Intel 40G

Virtio net

TX dma map

1. When transmit begin

2. Dma map per packet

1. When transmit begin

2. Dma map per packet

TX dma unmap

1. When transmit done

2. Dma unmap per packet

1. Before the next  transmit begin

2. Dma map per packet

RX dma map

1. When initialization

2.When free> I40E_RX_BUFFER_WRITE

1. When initialization

2. When free> size/2

RX dma unmap

1. When receive and reuse failed

2. When close

1. When receive one packet

2. Dma unmap per packet



Look forward to your reply.



Thanks,

Jason

BTW:

*1. Intel Ethernet Controller XL710(40G) driver:*

TX:

i40e_lan_xmit_frame

    ->i40e_xmit_frame_ring()

       ->i40e_tx_map()

         {

           ......

           dma =3D dma_map_single(tx_ring->dev, skb->data, size,
DMA_TO_DEVICE);

           ......

           dma =3D skb_frag_dma_map(tx_ring->dev, frag, 0, size,


DMA_TO_DEVICE);

           ......

         }



i40e_clean_tx_irq()

{

    ......

    /* unmap skb header data */

                                dma_unmap_single(tx_ring->dev,


dma_unmap_addr(tx_buf, dma),


dma_unmap_len(tx_buf, len),


DMA_TO_DEVICE);



                                /* clear tx_buffer data */

                                tx_buf->skb =3D NULL;

                                dma_unmap_len_set(tx_buf, len, 0);

    ......

    /* unmap remaining buffers */

                                while (tx_desc !=3D eop_desc) {

      /* unmap any remaining paged data */

                                                if (dma_unmap_len(tx_buf,
len)) {


dma_unmap_page(tx_ring->dev,


       dma_unmap_addr(tx_buf, dma),


       dma_unmap_len(tx_buf, len),


       DMA_TO_DEVICE);


dma_unmap_len_set(tx_buf, len, 0);

                                                }

                                                ......

                                }

    ......

}



i40e_vsi_free_tx_resources()

    ->i40e_free_tx_resources()

        ->i40e_clean_tx_ring()

            ->i40e_unmap_and_free_tx_resource()

              {

                  if (tx_buffer->skb) {


dev_kfree_skb_any(tx_buffer->skb);

                                                if
(dma_unmap_len(tx_buffer, len))


dma_unmap_single(ring->dev,



 dma_unmap_addr(tx_buffer, dma),



 dma_unmap_len(tx_buffer, len),



 DMA_TO_DEVICE);

                                } else if (dma_unmap_len(tx_buffer, len)) {

                                                dma_unmap_page(ring->dev,


       dma_unmap_addr(tx_buffer, dma),


       dma_unmap_len(tx_buffer, len),


       DMA_TO_DEVICE);

                                }

                                ......

              }

*RX:*

i40e_vsi_configure()

    ->i40e_vsi_configure_rx()

      {

        ......

        /* set up individual rings */

        for (i =3D 0; i < vsi->num_queue_pairs && !err; i++)

          err =3D i40e_configure_rx_ring(vsi->rx_rings[i]);

        ......

      }

        ->i40e_configure_rx_ring()

            ->i40e_alloc_rx_buffers()

              {

                ......

                do {

                  if (!i40e_alloc_mapped_page(rx_ring, bi))

                    goto no_buffers;

                  ......

                  cleaned_count--;

                              } while (cleaned_count);

                              ......

              }



i40e_clean_rx_irq

{

    ......

    if (cleaned_count >=3D I40E_RX_BUFFER_WRITE) {

                                                failure =3D failure ||


i40e_alloc_rx_buffers(rx_ring, cleaned_count);

                                                cleaned_count =3D 0;

                                }

    ......

/* we are reusing so sync this buffer for CPU use */

dma_sync_single_range_for_cpu(rx_ring->dev,


rx_buffer->dma,


rx_buffer->page_offset,


I40E_RXBUFFER_2048,


DMA_FROM_DEVICE);

    ......

}



i40e_vsi_free_rx_resources()

    ->i40e_free_rx_resources()

        ->i40e_clean_rx_ring()

          {

              ......

              dma_unmap_page(dev, rx_bi->dma, PAGE_SIZE, DMA_FROM_DEVICE);

              ......

          }



*2. virtio net driver:*

init_vqs()

    ->virtnet_alloc_queues()

    ->virtnet_find_vqs()

        ->vp_find_vqs()

            ->vp_try_to_find_vqs()

              ->vp_setup_vq()

                  ->setup_vq()

*TX:*

start_xmit()

    ->free_old_xmit_skbs()

      {

       ......

        virtqueue_get_buf()

            ->detach_buf()

              {

                ......

                vring_unmap_one(vq, &vq->vring.desc[i])

                ......

              }

        ......

      }

    ->xmit_skb()

        virtqueue_add_outbuf()

            ->virtqueue_add()

              {

                ......

                dma_addr_t addr =3D vring_map_one_sg(vq, sg, DMA_TO_DEVICE)=
;

                ......

              }

*RX:*

virtnet_receive()

    ->virtqueue_get_buf()

        ->detach_buf()

          {

            ......

            vring_unmap_one(vq, &vq->vring.desc[i])

            ......

          }

    ->receive_buf()

    ->try_fill_recv()

        ->add_recvbuf_small()

            ->virtqueue_add_inbuf()

                ->virtqueue_add()

                  {

                    ......

                    dma_addr_t addr =3D vring_map_one_sg(vq, sg,
DMA_TO_DEVICE);

                    ......

                  }

--f403045e1e1842c5d70548009af2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPjxtZXRhIG5hbWU9IkdlbmVyYXRvciIgY29udGVudD0i
TWljcm9zb2Z0IFdvcmQgMTQgKGZpbHRlcmVkIG1lZGl1bSkiPjxzdHlsZT48IS0tDQovKiBGb250
IERlZmluaXRpb25zICovDQpAZm9udC1mYWNlDQoJe2ZvbnQtZmFtaWx5OlNpbVN1bjsNCglwYW5v
c2UtMToyIDEgNiAwIDMgMSAxIDEgMSAxO30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6U2lt
U3VuOw0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAxIDE7fQ0KQGZvbnQtZmFjZQ0KCXtmb250
LWZhbWlseTpDYWxpYnJpOw0KCXBhbm9zZS0xOjIgMTUgNSAyIDIgMiA0IDMgMiA0O30NCkBmb250
LWZhY2UNCgl7Zm9udC1mYW1pbHk6U2ltU3VuOw0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAx
IDE7fQ0KLyogU3R5bGUgRGVmaW5pdGlvbnMgKi8NCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWws
IGRpdi5Nc29Ob3JtYWwNCgl7bWFyZ2luOjBpbjsNCgltYXJnaW4tYm90dG9tOi4wMDAxcHQ7DQoJ
Zm9udC1zaXplOjExLjBwdDsNCglmb250LWZhbWlseToiQ2FsaWJyaSIsInNhbnMtc2VyaWYiO30N
CmE6bGluaywgc3Bhbi5Nc29IeXBlcmxpbmsNCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCWNv
bG9yOmJsdWU7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTt9DQphOnZpc2l0ZWQsIHNwYW4u
TXNvSHlwZXJsaW5rRm9sbG93ZWQNCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCWNvbG9yOnB1
cnBsZTsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lO30NCnNwYW4uRW1haWxTdHlsZTE3DQoJ
e21zby1zdHlsZS10eXBlOnBlcnNvbmFsOw0KCWZvbnQtZmFtaWx5OiJDYWxpYnJpIiwic2Fucy1z
ZXJpZiI7DQoJY29sb3I6d2luZG93dGV4dDt9DQpzcGFuLkVtYWlsU3R5bGUxOA0KCXttc28tc3R5
bGUtdHlwZTpwZXJzb25hbC1yZXBseTsNCglmb250LWZhbWlseToiQ2FsaWJyaSIsInNhbnMtc2Vy
aWYiOw0KCWNvbG9yOiMxRjQ5N0Q7fQ0KLk1zb0NocERlZmF1bHQNCgl7bXNvLXN0eWxlLXR5cGU6
ZXhwb3J0LW9ubHk7DQoJZm9udC1zaXplOjEwLjBwdDt9DQpAcGFnZSBXb3JkU2VjdGlvbjENCgl7
c2l6ZTo4LjVpbiAxMS4waW47DQoJbWFyZ2luOjEuMGluIDEuMjVpbiAxLjBpbiAxLjI1aW47fQ0K
ZGl2LldvcmRTZWN0aW9uMQ0KCXtwYWdlOldvcmRTZWN0aW9uMTt9DQotLT48L3N0eWxlPjwvaGVh
ZD48Ym9keSBsYW5nPSJFTi1VUyIgbGluaz0iYmx1ZSIgdmxpbms9InB1cnBsZSI+PGRpdiBjbGFz
cz0iV29yZFNlY3Rpb24xIj48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6
IzFmNDk3ZCI+SGkgTWljaGFlbCw8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoDwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPkV4Y3VzZSBtZSBmb3IgZGlzdHVyYmluZyB5b3Ug
d2l0aCB0aGlzIGxldHRlciE8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9u
dC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssJnF1b3Q7c2Fucy1zZXJpZiZxdW90Oztjb2xvcjoj
MzMzMzMzO2JhY2tncm91bmQ6d2hpdGUiPjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+SeKAmW0gdXNpbmcgbGludXggNC43LjIg
dmlydGlvIGRyaXZlciArIFg4NiA2NCArIHNtYXJ0IG5pYyB0byB2YWxpZGF0ZSBQRiBhbmQgVkY8
L3NwYW4+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPiB2aXJ0aW88L3NwYW4+PHNwYW4gc3R5
bGU9ImNvbG9yOiMxZjQ5N2QiPiBwZXJmb3JtYW5jZS48L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoDwvc3Bhbj48L3A+PHAgY2xhc3M9
Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPlRoZSBWRuKAmXMgcGVyZm9y
bWFuY2UgaXMgJmd0OzFNcHBzLCBidXQgdGhlIFBG4oCZcyBwZXJmb3JtYW5jZSBpcyBvbmx5IMKg
NTAwS3BwcyBldmVuIGlmIHVzaW5nIDggdmlydGlvIHF1ZXVlcy48L3NwYW4+PC9wPjxwIGNsYXNz
PSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoDwvc3Bhbj48L3A+PHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPlNvIEkgcmV2aWV3
ZWQgdmlydGlvIGlvbW11IHBhdGNoIGluIGRldGFpbC4gSSB3b3JyeSDCoGRtYSBtYXAvdW5tYXAg
Y29zdCBtYW55IGN5Y2xlcy7CoCBEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbj8gVGhhbmtzIGEg
bG90ITwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMx
ZjQ5N2QiPsKgPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29s
b3I6IzFmNDk3ZCI+VG9kYXkgSSBhbHNvIHJldmlld2VkIEludGVsIDQwRyBkcml2ZXIgb2YgbGlu
dXggNC43LjIgYW5kIGNvbXBhcmVkIHdpdGggdmlydGlvIG5ldCBkcml2ZXIuIEkgZm9jdXMgb24g
YnVmZmVyIG1hbmFnZW1lbnQgYW5kIGxpc3QgdGhlIGRpZmZlcmVuY2UgaW4gYmVsb3cgdGFibGU6
PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3
ZCI+wqA8L3NwYW4+PC9wPjx0YWJsZSBjbGFzcz0iTXNvTm9ybWFsVGFibGUiIGJvcmRlcj0iMCIg
Y2VsbHNwYWNpbmc9IjAiIGNlbGxwYWRkaW5nPSIwIiBzdHlsZT0iYm9yZGVyLWNvbGxhcHNlOmNv
bGxhcHNlIj48dHI+PHRkIHdpZHRoPSIxNDgiIHZhbGlnbj0idG9wIiBzdHlsZT0id2lkdGg6MTEw
LjdwdDtib3JkZXI6c29saWQgd2luZG93dGV4dCAxLjBwdDtwYWRkaW5nOjBpbiA1LjRwdCAwaW4g
NS40cHQiPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7C
oDwvc3Bhbj48L3A+PC90ZD48dGQgd2lkdGg9IjI2MCIgdmFsaWduPSJ0b3AiIHN0eWxlPSJ3aWR0
aDoxOTQuOXB0O2JvcmRlcjpzb2xpZCB3aW5kb3d0ZXh0IDEuMHB0O2JvcmRlci1sZWZ0Om5vbmU7
cGFkZGluZzowaW4gNS40cHQgMGluIDUuNHB0Ij48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iY29sb3I6IzFmNDk3ZCI+SW50ZWwgNDBHPC9zcGFuPjwvcD48L3RkPjx0ZCB3aWR0aD0i
Mjg4IiB2YWxpZ249InRvcCIgc3R5bGU9IndpZHRoOjMuMGluO2JvcmRlcjpzb2xpZCB3aW5kb3d0
ZXh0IDEuMHB0O2JvcmRlci1sZWZ0Om5vbmU7cGFkZGluZzowaW4gNS40cHQgMGluIDUuNHB0Ij48
cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+VmlydGlvIG5l
dDwvc3Bhbj48L3A+PC90ZD48L3RyPjx0cj48dGQgd2lkdGg9IjE0OCIgdmFsaWduPSJ0b3AiIHN0
eWxlPSJ3aWR0aDoxMTAuN3B0O2JvcmRlcjpzb2xpZCB3aW5kb3d0ZXh0IDEuMHB0O2JvcmRlci10
b3A6bm9uZTtwYWRkaW5nOjBpbiA1LjRwdCAwaW4gNS40cHQiPjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj5UWCBkbWEgbWFwPC9zcGFuPjwvcD48L3RkPjx0
ZCB3aWR0aD0iMjYwIiB2YWxpZ249InRvcCIgc3R5bGU9IndpZHRoOjE5NC45cHQ7Ym9yZGVyLXRv
cDpub25lO2JvcmRlci1sZWZ0Om5vbmU7Ym9yZGVyLWJvdHRvbTpzb2xpZCB3aW5kb3d0ZXh0IDEu
MHB0O2JvcmRlci1yaWdodDpzb2xpZCB3aW5kb3d0ZXh0IDEuMHB0O3BhZGRpbmc6MGluIDUuNHB0
IDBpbiA1LjRwdCI+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5
N2QiPjEuIFdoZW4gdHJhbnNtaXQgYmVnaW48L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj4yLiBEbWEgbWFwIHBlciBwYWNrZXQgPC9zcGFu
PjwvcD48L3RkPjx0ZCB3aWR0aD0iMjg4IiB2YWxpZ249InRvcCIgc3R5bGU9IndpZHRoOjMuMGlu
O2JvcmRlci10b3A6bm9uZTtib3JkZXItbGVmdDpub25lO2JvcmRlci1ib3R0b206c29saWQgd2lu
ZG93dGV4dCAxLjBwdDtib3JkZXItcmlnaHQ6c29saWQgd2luZG93dGV4dCAxLjBwdDtwYWRkaW5n
OjBpbiA1LjRwdCAwaW4gNS40cHQiPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJj
b2xvcjojMWY0OTdkIj4xLiBXaGVuIHRyYW5zbWl0IGJlZ2luPC9zcGFuPjwvcD48cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+Mi4gRG1hIG1hcCBwZXIgcGFj
a2V0PC9zcGFuPjwvcD48L3RkPjwvdHI+PHRyPjx0ZCB3aWR0aD0iMTQ4IiB2YWxpZ249InRvcCIg
c3R5bGU9IndpZHRoOjExMC43cHQ7Ym9yZGVyOnNvbGlkIHdpbmRvd3RleHQgMS4wcHQ7Ym9yZGVy
LXRvcDpub25lO3BhZGRpbmc6MGluIDUuNHB0IDBpbiA1LjRwdCI+PHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPlRYIGRtYSB1bm1hcDwvc3Bhbj48L3A+PC90
ZD48dGQgd2lkdGg9IjI2MCIgdmFsaWduPSJ0b3AiIHN0eWxlPSJ3aWR0aDoxOTQuOXB0O2JvcmRl
ci10b3A6bm9uZTtib3JkZXItbGVmdDpub25lO2JvcmRlci1ib3R0b206c29saWQgd2luZG93dGV4
dCAxLjBwdDtib3JkZXItcmlnaHQ6c29saWQgd2luZG93dGV4dCAxLjBwdDtwYWRkaW5nOjBpbiA1
LjRwdCAwaW4gNS40cHQiPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjoj
MWY0OTdkIj4xLiBXaGVuIHRyYW5zbWl0IGRvbmU8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj4yLiBEbWEgdW5tYXAgcGVyIHBhY2tldDwv
c3Bhbj48L3A+PC90ZD48dGQgd2lkdGg9IjI4OCIgdmFsaWduPSJ0b3AiIHN0eWxlPSJ3aWR0aDoz
LjBpbjtib3JkZXItdG9wOm5vbmU7Ym9yZGVyLWxlZnQ6bm9uZTtib3JkZXItYm90dG9tOnNvbGlk
IHdpbmRvd3RleHQgMS4wcHQ7Ym9yZGVyLXJpZ2h0OnNvbGlkIHdpbmRvd3RleHQgMS4wcHQ7cGFk
ZGluZzowaW4gNS40cHQgMGluIDUuNHB0Ij48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iY29sb3I6IzFmNDk3ZCI+MS4gQmVmb3JlIHRoZSBuZXh0IMKgdHJhbnNtaXQgYmVnaW48L3Nw
YW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj4y
LiBEbWEgbWFwIHBlciBwYWNrZXQ8L3NwYW4+PC9wPjwvdGQ+PC90cj48dHI+PHRkIHdpZHRoPSIx
NDgiIHZhbGlnbj0idG9wIiBzdHlsZT0id2lkdGg6MTEwLjdwdDtib3JkZXI6c29saWQgd2luZG93
dGV4dCAxLjBwdDtib3JkZXItdG9wOm5vbmU7cGFkZGluZzowaW4gNS40cHQgMGluIDUuNHB0Ij48
cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+UlggZG1hIG1h
cDwvc3Bhbj48L3A+PC90ZD48dGQgd2lkdGg9IjI2MCIgdmFsaWduPSJ0b3AiIHN0eWxlPSJ3aWR0
aDoxOTQuOXB0O2JvcmRlci10b3A6bm9uZTtib3JkZXItbGVmdDpub25lO2JvcmRlci1ib3R0b206
c29saWQgd2luZG93dGV4dCAxLjBwdDtib3JkZXItcmlnaHQ6c29saWQgd2luZG93dGV4dCAxLjBw
dDtwYWRkaW5nOjBpbiA1LjRwdCAwaW4gNS40cHQiPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IHN0eWxlPSJjb2xvcjojMWY0OTdkIj4xLiBXaGVuIGluaXRpYWxpemF0aW9uPC9zcGFuPjwvcD48
cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+Mi5XaGVuIGZy
ZWUmZ3Q7IEk0MEVfUlhfQlVGRkVSX1dSSVRFPC9zcGFuPjwvcD48L3RkPjx0ZCB3aWR0aD0iMjg4
IiB2YWxpZ249InRvcCIgc3R5bGU9IndpZHRoOjMuMGluO2JvcmRlci10b3A6bm9uZTtib3JkZXIt
bGVmdDpub25lO2JvcmRlci1ib3R0b206c29saWQgd2luZG93dGV4dCAxLjBwdDtib3JkZXItcmln
aHQ6c29saWQgd2luZG93dGV4dCAxLjBwdDtwYWRkaW5nOjBpbiA1LjRwdCAwaW4gNS40cHQiPjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj4xLiBXaGVuIGlu
aXRpYWxpemF0aW9uPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0i
Y29sb3I6IzFmNDk3ZCI+Mi4gV2hlbiBmcmVlJmd0OyBzaXplLzI8L3NwYW4+PC9wPjwvdGQ+PC90
cj48dHI+PHRkIHdpZHRoPSIxNDgiIHZhbGlnbj0idG9wIiBzdHlsZT0id2lkdGg6MTEwLjdwdDti
b3JkZXI6c29saWQgd2luZG93dGV4dCAxLjBwdDtib3JkZXItdG9wOm5vbmU7cGFkZGluZzowaW4g
NS40cHQgMGluIDUuNHB0Ij48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6
IzFmNDk3ZCI+UlggZG1hIHVubWFwPC9zcGFuPjwvcD48L3RkPjx0ZCB3aWR0aD0iMjYwIiB2YWxp
Z249InRvcCIgc3R5bGU9IndpZHRoOjE5NC45cHQ7Ym9yZGVyLXRvcDpub25lO2JvcmRlci1sZWZ0
Om5vbmU7Ym9yZGVyLWJvdHRvbTpzb2xpZCB3aW5kb3d0ZXh0IDEuMHB0O2JvcmRlci1yaWdodDpz
b2xpZCB3aW5kb3d0ZXh0IDEuMHB0O3BhZGRpbmc6MGluIDUuNHB0IDBpbiA1LjRwdCI+PHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPjEuIFdoZW4gcmVjZWl2
ZSBhbmQgcmV1c2UgZmFpbGVkPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iY29sb3I6IzFmNDk3ZCI+Mi4gV2hlbiBjbG9zZTwvc3Bhbj48L3A+PC90ZD48dGQgd2lk
dGg9IjI4OCIgdmFsaWduPSJ0b3AiIHN0eWxlPSJ3aWR0aDozLjBpbjtib3JkZXItdG9wOm5vbmU7
Ym9yZGVyLWxlZnQ6bm9uZTtib3JkZXItYm90dG9tOnNvbGlkIHdpbmRvd3RleHQgMS4wcHQ7Ym9y
ZGVyLXJpZ2h0OnNvbGlkIHdpbmRvd3RleHQgMS4wcHQ7cGFkZGluZzowaW4gNS40cHQgMGluIDUu
NHB0Ij48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+MS4g
V2hlbiByZWNlaXZlIG9uZSBwYWNrZXQ8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxz
cGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj4yLiBEbWEgdW5tYXAgcGVyIHBhY2tldDwvc3Bhbj48
L3A+PC90ZD48L3RyPjwvdGFibGU+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNv
bG9yOiMxZjQ5N2QiPsKgPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iY29sb3I6IzFmNDk3ZCI+TG9va8KgZm9yd2FyZMKgdG/CoHlvdXLCoHJlcGx5Ljwvc3Bhbj48
L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgPC9z
cGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+
VGhhbmtzLDwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9y
OiMxZjQ5N2QiPkphc29uPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iY29sb3I6IzFmNDk3ZCI+QlRXOjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+
PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPjEuIEludGVsIEV0aGVybmV0IENvbnRyb2xsZXIg
WEw3MTAoNDBHKSBkcml2ZXI6PC9zcGFuPjwvYj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNw
YW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPlRYOjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPmk0MGVfbGFuX3htaXRfZnJhbWU8L3NwYW4+
PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKg
wqAgLSZndDtpNDBlX3htaXRfZnJhbWVfcmluZygpPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgIC0mZ3Q7aTQwZV90
eF9tYXAoKTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9y
OiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqAgezwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgIC4uLi4u
Ljwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5
N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYSA9IGRtYV9tYXBfc2luZ2xlKHR4X3JpbmctJmd0
O2Rldiwgc2tiLSZndDtkYXRhLCBzaXplLCBETUFfVE9fREVWSUNFKTs8L3NwYW4+PC9wPjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDC
oMKgwqDCoCAuLi4uLi48L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxl
PSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWEgPSBza2JfZnJhZ19kbWFf
bWFwKHR4X3JpbmctJmd0O2RldiwgZnJhZywgMCwgc2l6ZSw8L3NwYW4+PC9wPjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKg
wqDCoMKgIERNQV9UT19ERVZJQ0UpOzwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNw
YW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgIC4uLi4uLjwvc3Bh
bj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKg
wqDCoMKgwqDCoMKgwqAgfcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9y
OiMxZjQ5N2QiPsKgPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0i
Y29sb3I6IzFmNDk3ZCI+aTQwZV9jbGVhbl90eF9pcnEoKTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPns8L3NwYW4+PC9wPjxwIGNsYXNz
PSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqAgLi4uLi4uPC9z
cGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+
wqAgwqDCoC8qIHVubWFwIHNrYiBoZWFkZXIgZGF0YSAqLzwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV91bm1hcF9zaW5n
bGUodHhfcmluZy0mZ3Q7ZGV2LDwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4g
c3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFfdW5tYXBfYWRkcih0eF9idWYs
IGRtYSksPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6
IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV91bm1hcF9sZW4odHhfYnVmLCBsZW4pLDwvc3Bhbj48
L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBETUFfVE9fREVWSUNFKTs8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxz
cGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoDwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIGNsZWFyIHR4X2J1ZmZlciBk
YXRhICovPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6
IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdHhfYnVmLSZndDtza2IgPSBOVUxMOzwvc3Bhbj48L3A+PHAgY2xhc3M9
Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV91bm1hcF9s
ZW5fc2V0KHR4X2J1ZiwgbGVuLCAwKTs8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxz
cGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqAgLi4uLi4uPC9zcGFuPjwvcD48cCBjbGFz
cz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgIC8qIHVubWFw
IHJlbWFpbmluZyBidWZmZXJzICovPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3Bh
biBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd2hpbGUgKHR4X2Rlc2MgIT0gZW9wX2Rlc2Mp
IHs8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0
OTdkIj7CoMKgwqDCoMKgIC8qIHVubWFwIGFueSByZW1haW5pbmcgcGFnZWQgZGF0YSAqLzwvc3Bh
bj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRtYV91bm1hcF9sZW4odHhf
YnVmLCBsZW4pKSB7PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0i
Y29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV91bm1hcF9wYWdlKHR4X3JpbmctJmd0O2Rl
diw8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0
OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDC
oMKgwqAgZG1hX3VubWFwX2FkZHIodHhfYnVmLCBkbWEpLDwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoMKgwqDCoCBkbWFfdW5tYXBfbGVuKHR4X2J1
ZiwgbGVuKSw8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xv
cjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDC
oMKgwqDCoMKgwqAgRE1BX1RPX0RFVklDRSk7PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFs
Ij48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV91bm1hcF9sZW5f
c2V0KHR4X2J1ZiwgbGVuLCAwKTs8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH08L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjoj
MWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC4uLi4uLjwvc3Bh
bj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH08L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjoj
MWY0OTdkIj7CoMKgwqAgLi4uLi4uPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3Bh
biBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+fTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+aTQwZV92c2lfZnJlZV90eF9yZXNvdXJj
ZXMoKTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMx
ZjQ5N2QiPsKgwqDCoCAtJmd0O2k0MGVfZnJlZV90eF9yZXNvdXJjZXMoKTwvc3Bhbj48L3A+PHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDC
oMKgIC0mZ3Q7aTQwZV9jbGVhbl90eF9yaW5nKCk8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0m
Z3Q7aTQwZV91bm1hcF9hbmRfZnJlZV90eF9yZXNvdXJjZSgpPC9zcGFuPjwvcD48cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIMKgezwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNv
bG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHR4X2J1
ZmZlci0mZ3Q7c2tiKSB7PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2
X2tmcmVlX3NrYl9hbnkodHhfYnVmZmVyLSZndDtza2IpOzwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChkbWFfdW5tYXBfbGVuKHR4X2J1ZmZlciwgbGVuKSk8L3NwYW4+
PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRtYV91bm1hcF9zaW5nbGUocmluZy0mZ3Q7ZGV2LDwvc3Bhbj48L3A+PHAgY2xhc3M9
Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IMKgZG1hX3VubWFwX2FkZHIodHhfYnVmZmVyLCBkbWEpLDwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKg
ZG1hX3VubWFwX2xlbih0eF9idWZmZXIsIGxlbiksPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqBETUFf
VE9fREVWSUNFKTs8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJj
b2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoZG1hX3VubWFwX2xlbih0eF9idWZmZXIsIGxl
bikpIHs8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjoj
MWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFfdW5tYXBfcGFn
ZShyaW5nLSZndDtkZXYsPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoGRtYV91bm1hcF9hZGRy
KHR4X2J1ZmZlciwgZG1hKSw8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0
eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoMKgwqDCoMKgZG1hX3VubWFwX2xl
bih0eF9idWZmZXIsIGxlbiksPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoERNQV9UT19ERVZJ
Q0UpOzwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMx
ZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9
ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLi4uLi4uPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFs
Ij48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+PHNwYW4gc3R5bGU9ImNvbG9yOiMx
ZjQ5N2QiPlJYOjwvc3Bhbj48L2I+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxl
PSJjb2xvcjojMWY0OTdkIj5pNDBlX3ZzaV9jb25maWd1cmUoKTwvc3Bhbj48L3A+PHAgY2xhc3M9
Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoCAtJmd0O2k0MGVf
dnNpX2NvbmZpZ3VyZV9yeCgpPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoCB7PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNv
Tm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqAgLi4uLi4u
PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3
ZCI+wqDCoMKgwqDCoMKgwqAgLyogc2V0IHVwIGluZGl2aWR1YWwgcmluZ3MgKi88L3NwYW4+PC9w
PjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDC
oMKgwqDCoCBmb3IgKGkgPSAwOyBpICZsdDsgdnNpLSZndDtudW1fcXVldWVfcGFpcnMgJmFtcDsm
YW1wOyAhZXJyOyBpKyspPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgIGVyciA9IGk0MGVfY29uZmlndXJl
X3J4X3JpbmcodnNpLSZndDtyeF9yaW5nc1tpXSk7PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqAgLi4uLi4uPC9z
cGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+
wqDCoMKgwqDCoCB9PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0i
Y29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqAgLSZndDtpNDBlX2NvbmZpZ3VyZV9yeF9yaW5n
KCk8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0
OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoCDCoC0mZ3Q7aTQwZV9hbGxvY19yeF9idWZmZXJzKCk8
L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdk
Ij7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC4uLi4uLjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9
ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbyB7PC9zcGFu
PjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWk0MGVfYWxsb2NfbWFwcGVkX3Bh
Z2UocnhfcmluZywgYmkpKTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5
bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGdvdG8gbm9fYnVmZmVyczs8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0
eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC4u
Li4uLjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMx
ZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xlYW5lZF9jb3VudC0t
Ozwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5
N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9IHdoaWxlIChjbGVhbmVkX2NvdW50KTs8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLi4uLi4uPC9zcGFuPjwvcD48cCBjbGFz
cz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfSDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwvc3Bhbj48L3A+PHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgPC9zcGFuPjwv
cD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+aTQwZV9j
bGVhbl9yeF9pcnE8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJj
b2xvcjojMWY0OTdkIj57PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgIC4uLi4uLjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoCBpZiAoY2xlYW5lZF9jb3Vu
dCAmZ3Q7PSBJNDBFX1JYX0JVRkZFUl9XUklURSkgezwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZmFpbHVyZSA9IGZhaWx1cmUgfHw8L3NwYW4+PC9wPjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqAgaTQw
ZV9hbGxvY19yeF9idWZmZXJzKHJ4X3JpbmcsIGNsZWFuZWRfY291bnQpOzwvc3Bhbj48L3A+PHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xlYW5lZF9jb3VudCA9IDA7PC9zcGFuPjwvcD48
cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTwv
c3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2Qi
PsKgwqDCoCAuLi4uLi48L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJ0ZXh0
LWluZGVudDo5LjBwdCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPi8qIHdlIGFyZSByZXVz
aW5nIHNvIHN5bmMgdGhpcyBidWZmZXIgZm9yIENQVSB1c2UgKi88L3NwYW4+PC9wPjxwIGNsYXNz
PSJNc29Ob3JtYWwiIHN0eWxlPSJ0ZXh0LWluZGVudDo5LjBwdCI+PHNwYW4gc3R5bGU9ImNvbG9y
OiMxZjQ5N2QiPmRtYV9zeW5jX3NpbmdsZV9yYW5nZV9mb3JfY3B1KHJ4X3JpbmctJmd0O2Rldiw8
L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdk
Ij7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoCByeF9idWZmZXItJmd0O2RtYSw8L3NwYW4+PC9wPjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgwqDCoMKgwqDCoCByeF9idWZmZXItJmd0O3BhZ2Vfb2Zmc2V0LDwvc3Bhbj48L3A+PHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDC
oMKgwqDCoMKgIEk0MEVfUlhCVUZGRVJfMjA0OCw8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoCBE
TUFfRlJPTV9ERVZJQ0UpOzwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5
bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoCAuLi4uLi48L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj59PC9zcGFuPjwvcD48cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqA8L3NwYW4+PC9wPjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj5pNDBlX3ZzaV9mcmVl
X3J4X3Jlc291cmNlcygpPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgIC0mZ3Q7aTQwZV9mcmVlX3J4X3Jlc291cmNlcygpPC9z
cGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+
wqDCoMKgwqDCoMKgwqAgLSZndDtpNDBlX2NsZWFuX3J4X3JpbmcoKTwvc3Bhbj48L3A+PHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKg
wqDCoCB7PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6
IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLi4uLi4uPC9zcGFuPjwvcD48cCBj
bGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZG1hX3VubWFwX3BhZ2UoZGV2LCByeF9iaS0mZ3Q7ZG1hLCBQQUdFX1NJ
WkUsIERNQV9GUk9NX0RFVklDRSk7PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3Bh
biBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLi4uLi4u
PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3
ZCI+wqDCoMKgwqDCoMKgwqDCoMKgIH08L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxz
cGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoDwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1h
bCI+PGI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPjIuIHZpcnRpbyBuZXQgZHJpdmVyOjwv
c3Bhbj48L2I+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0
OTdkIj5pbml0X3ZxcygpPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgIC0mZ3Q7dmlydG5ldF9hbGxvY19xdWV1ZXMoKTwvc3Bh
bj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKg
wqDCoCAtJmd0O3ZpcnRuZXRfZmluZF92cXMoKTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgIC0mZ3Q7dnBfZmlu
ZF92cXMoKTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9y
OiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSZndDt2cF90cnlfdG9fZmluZF92cXMo
KTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5
N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0mZ3Q7dnBfc2V0dXBfdnEoKTwvc3Bhbj48
L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSZndDtzZXR1cF92cSgpwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+PHNw
YW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPlRYOjwvc3Bhbj48L2I+PC9wPjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj5zdGFydF94bWl0KCk8L3NwYW4+PC9w
PjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqAg
LSZndDtmcmVlX29sZF94bWl0X3NrYnMoKTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqAgezwvc3Bhbj48L3A+PHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKg
Li4uLi4uPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6
IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqAgdmlydHF1ZXVlX2dldF9idWYoKTwvc3Bhbj48L3A+PHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLSZndDtkZXRhY2hfYnVmKCk8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB7PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFm
NDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC4uLi4uLjwvc3Bhbj48L3A+PHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB2cmluZ191bm1hcF9vbmUodnEsICZhbXA7dnEtJmd0O3ZyaW5n
LmRlc2NbaV0pPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29s
b3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC4uLi4uLjwvc3Bhbj48
L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH08L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxz
cGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoCAuLi4uLi48L3NwYW4+PC9w
PjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDC
oMKgIH08L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjoj
MWY0OTdkIj7CoMKgwqAgLSZndDt4bWl0X3NrYigpPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqAgdmlydHF1ZXVl
X2FkZF9vdXRidWYoKTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9
ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSZndDt2aXJ0cXVldWVfYWRk
KCk8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0
OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNv
Tm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC4uLi4uLjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5
bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFfYWRk
cl90IGFkZHIgPSB2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgRE1BX1RPX0RFVklDRSk7PC9zcGFu
PjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC4uLi4uLjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH08L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxiPjxzcGFuIHN0eWxlPSJj
b2xvcjojMWY0OTdkIj5SWDo8L3NwYW4+PC9iPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3Bh
biBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+dmlydG5ldF9yZWNlaXZlKCk8L3NwYW4+PC9wPjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqAgLSZndDt2
aXJ0cXVldWVfZ2V0X2J1ZigpPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqAgLSZndDtkZXRhY2hfYnVmKCk8L3Nw
YW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7C
oMKgwqDCoMKgwqDCoMKgwqAgezwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4g
c3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLi4uLi4uPC9zcGFu
PjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB2cmluZ191bm1hcF9vbmUodnEsICZhbXA7dnEtJmd0O3ZyaW5n
LmRlc2NbaV0pPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29s
b3I6IzFmNDk3ZCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuLi4uLi48L3NwYW4+PC9wPjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDC
oMKgwqAgfTwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9y
OiMxZjQ5N2QiPsKgwqDCoCAtJmd0O3JlY2VpdmVfYnVmKCkgPC9zcGFuPjwvcD48cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+wqDCoMKgwqAtJmd0O3RyeV9m
aWxsX3JlY3YoKSA8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJj
b2xvcjojMWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgLSZndDthZGRfcmVjdmJ1Zl9zbWFsbCgpPC9z
cGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iY29sb3I6IzFmNDk3ZCI+
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtJmd0O3ZpcnRxdWV1ZV9hZGRfaW5idWYoKTwvc3Bhbj48
L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDC
oMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKgwqAtJmd0O3ZpcnRxdWV1ZV9hZGQoKTwvc3Bhbj48L3A+
PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgezwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHNwYW4gc3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC4uLi4uLjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4g
c3R5bGU9ImNvbG9yOiMxZjQ5N2QiPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRtYV9hZGRyX3QgYWRkciA9IHZyaW5nX21hcF9vbmVfc2codnEsIHNnLCBETUFfVE9fREVW
SUNFKTs8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjoj
MWY0OTdkIj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuLi4uLi48L3Nw
YW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJjb2xvcjojMWY0OTdkIj7C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH3CoMKgwqAgPC9zcGFuPjwvcD48cCBj
bGFzcz0iTXNvTm9ybWFsIj7CoDwvcD48L2Rpdj48L2JvZHk+PC9odG1sPg0K
--f403045e1e1842c5d70548009af2--

--===============6427398547118528109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6427398547118528109==--
