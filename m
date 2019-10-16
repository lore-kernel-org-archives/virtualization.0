From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
Date: Wed, 16 Oct 2019 08:12:01 +0200
Message-ID: <20191016061201.iinqjcw6trx5qztq__46721.5312340826$1571206334$gmane$org@sirius.home.kraxel.org>
References: <20190912094121.228435-1-tfiga@chromium.org>
	<20190917132305.GV3958@phenom.ffwll.local>
	<CAAFQd5ADmObo1yVnFGaWDU=DHF+tex3tWJxTZLkxv=EdGNNM7A@mail.gmail.com>
	<20191008100328.GN16989@phenom.ffwll.local>
	<CAAFQd5CR2YhyNoSv7=nUhPQ7Nap6n36DrtsCfqS+-iWydAqbNA@mail.gmail.com>
	<20191008150435.GO16989@phenom.ffwll.local>
	<CAAFQd5DhKn_2uSA=1JDSj0H98aT8X9UjxWaTBwZCDfOC7YR5Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAAFQd5DhKn_2uSA=1JDSj0H98aT8X9UjxWaTBwZCDfOC7YR5Sg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: Zach Reizner <zachr@chromium.org>, David Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Keiichi Watanabe <keiichiw@chromium.org>, stevensd@chromium.org, Daniel Vetter <daniel@ffwll.ch>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> up later when given a buffer index. But we would still need to make
> the DMA-buf itself importable. For virtio-gpu I guess that would mean
> returning an sg_table backed by the shadow buffer pages.

The virtio-gpu driver in drm-misc-next supports dma-buf exports.

cheers,
  Gerd
