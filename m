From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Date: Fri, 14 Feb 2020 13:22:47 +0100
Message-ID: <3144806d-436e-86a1-2e29-74f7027f7f0b@de.ibm.com>
References: <20200107042401-mutt-send-email-mst@kernel.org>
 <CAJaqyWfngzP4d01B6+Sqt8FXN6jX7kGegjx8ie4no_1Er3igQA@mail.gmail.com>
 <43a5dbaa-9129-e220-8483-45c60a82c945@de.ibm.com>
 <e299afca8e22044916abbf9fbbd0bff6b0ee9e13.camel@redhat.com>
 <4c3f70b7-723a-8b0f-ac49-babef1bcc180@de.ibm.com>
 <50a79c3491ac483583c97df2fac29e2c3248fdea.camel@redhat.com>
 <8fbbfb49-99d1-7fee-e713-d6d5790fe866@de.ibm.com>
 <2364d0728c3bb4bcc0c13b591f774109a9274a30.camel@redhat.com>
 <bb9fb726-306c-5330-05aa-a86bd1b18097@de.ibm.com>
 <468983fad50a5e74a739f71487f0ea11e8d4dfd1.camel@redhat.com>
 <2dc1df65-1431-3917-40e5-c2b12096e2a7@de.ibm.com>
 <bd9c9b4d99abd20d5420583af5a4954ea1cf4618.camel@redhat.com>
 <e11ba53c-a5fa-0518-2e06-9296897ed529@de.ibm.com>
 <CAJaqyWfJFArAdpOwehTn5ci-frqai+pazGgcn2VvQSebqGRVtg@mail.gmail.com>
 <80520391-d90d-e10d-a107-7a18f2810900@de.ibm.com>
 <dabe59fe-e068-5935-f49e-bc1da3d8471a@de.ibm.com>
 <35dca16b9a85eb203f35d3e55dcaa9d0dae5a922.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35dca16b9a85eb203f35d3e55dcaa9d0dae5a922.camel@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



On 14.02.20 13:17, Eugenio Pérez wrote:
> Can you try the inlined patch over 52c36ce7f334 ("vhost: use batched version by default")? My intention is to check if
> "strange VHOST_SET_VRING_BASE" line appears. In previous tests, it appears very fast, but maybe it takes some time for
> it to appear, or it does not appear anymore.

  LD [M]  drivers/vhost/vhost_vsock.o
  CC [M]  drivers/vhost/vhost.o
In file included from ./include/linux/printk.h:331,
                 from ./include/linux/kernel.h:15,
                 from ./include/linux/list.h:9,
                 from ./include/linux/wait.h:7,
                 from ./include/linux/eventfd.h:13,
                 from drivers/vhost/vhost.c:13:
drivers/vhost/vhost.c: In function ‘fetch_descs’:
drivers/vhost/vhost.c:2330:56: error: ‘struct vhost_virtqueue’ has no member named ‘first_desc’
 2330 |   vq, vq->last_avail_idx, vq->avail_idx, vq->ndescs, vq->first_desc);
      |                                                        ^~
./include/linux/dynamic_debug.h:125:15: note: in definition of macro ‘__dynamic_func_call’
  125 |   func(&id, ##__VA_ARGS__);  \
      |               ^~~~~~~~~~~
./include/linux/dynamic_debug.h:153:2: note: in expansion of macro ‘_dynamic_func_call’
  153 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:335:2: note: in expansion of macro ‘dynamic_pr_debug’
  335 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
drivers/vhost/vhost.c:2328:2: note: in expansion of macro ‘pr_debug’
 2328 |  pr_debug(
      |  ^~~~~~~~
make[2]: *** [scripts/Makefile.build:266: drivers/vhost/vhost.o] Error 1
make[1]: *** [scripts/Makefile.build:503: drivers/vhost] Error 2
