From: "kraxel@redhat.com" <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: add dma sync for dma mapped virtio gpu
	framebuffer pages
Date: Wed, 19 Sep 2018 13:34:06 +0200
Message-ID: <20180919113406.ukhgbiukx7vsuinw__38544.5283413448$1537356725$gmane$org@sirius.home.kraxel.org>
References: <20180919070931.91168-1-jiandi.an@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180919070931.91168-1-jiandi.an@amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "An, Jiandi" <Jiandi.An@amd.com>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 19, 2018 at 07:09:53AM +0000, An, Jiandi wrote:
> With virtio gpu ttm-pages being dma mapped, dma sync is needed when
> swiotlb is used as bounce buffers, before TRANSFER_TO_HOST_2D/3D
> commands are sent.

Pushed to drm-misc-next.

thanks,
  Gerd
