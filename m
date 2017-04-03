From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/2] drm: virtio: add virtio_gpu_translate_format
Date: Mon, 03 Apr 2017 11:05:28 +0200
Message-ID: <1491210328.17505.34.camel__34391.74909513$1491210346$gmane$org@redhat.com>
References: <20170403070845.10793-1-kraxel@redhat.com>
	<20170403070845.10793-2-kraxel@redhat.com>
	<20170403075110.besn4qv53nhwlrhu@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170403075110.besn4qv53nhwlrhu@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: lvivier@redhat.com, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mo, 2017-04-03 at 09:51 +0200, Daniel Vetter wrote:
> On Mon, Apr 03, 2017 at 09:08:44AM +0200, Gerd Hoffmann wrote:
> > Factors out code, no functional change.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Ugh on the big endian define, I guess we'll never managed to figure this
> aspect of drm pixel formats out correctly - they're supposed to encode
> endinaness.

Oh, ok.  (reading your patch replies out-of-order).

Yep, in that case it maybe is a good idea to discuss fourcc
semantics ...

cheers,
  Gerd
