From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v6 11/18] drm/virtio: switch from ttm to gem shmem helpers
Date: Thu, 4 Jul 2019 14:33:26 +0100
Message-ID: <CACvgo53tSNa9=3LvmEdZvSp8g4oQF=cuue4UyTMjBtSKsfR0Ew__25866.9843476795$1562247209$gmane$org@mail.gmail.com>
References: <20190702141903.1131-1-kraxel@redhat.com>
	<20190702141903.1131-12-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190702141903.1131-12-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Gerd,

On Tue, 2 Jul 2019 at 15:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
>         .gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,

I think that you can drop this entry-point. AFAICT it's only purpose
is to return an error - something already handled by core DRM when the
function pointer is NULL.
It's not strictly related to this series, so feel free to keep is a
separate standalone patch.

-Emil
