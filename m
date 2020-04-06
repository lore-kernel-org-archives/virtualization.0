From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
Date: Mon, 6 Apr 2020 22:12:56 +0800
Message-ID: <0f4f2502-e810-e87a-2fba-dc887d2f4272@redhat.com>
References: <20200405081355.2870-1-mst@redhat.com>
 <20200406130927.GA20291@infradead.org>
 <20200406095931-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200406095931-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/6 =E4=B8=8B=E5=8D=8810:02, Michael S. Tsirkin wrote:
> On Mon, Apr 06, 2020 at 06:09:27AM -0700, Christoph Hellwig wrote:
>> Pleae just drop the code - we should not add new drivers with custom
>> DMA ops.
> I'm not sure there's another way to do this: this not a driver, it's a
> software emulator that pretends to be an actual device. We can't
> have the platform supply DMA ops here since the platform is a regular
> x86 or whatever.


Yes, actually vdpa-sim does not depends on HAS_DMA. Maybe we can do=20
shortcut like dev->dma_ops =3D vdpasim_dma_ops;

Thanks


>
