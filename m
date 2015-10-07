From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] drm/virtio: use %llu format string form atomic64_t
Date: Wed, 7 Oct 2015 11:45:02 +0100
Message-ID: <20151007104502.GH21513__24861.0199931592$1444214745$gmane$org@n2100.arm.linux.org.uk>
References: <5082760.FgB9zHNfte@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5082760.FgB9zHNfte@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Dave Airlie <airlied@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 07, 2015 at 12:41:21PM +0200, Arnd Bergmann wrote:
> The virtgpu driver prints the last_seq variable using the %ld or
> %lu format string, which does not work correctly on all architectures
> and causes this compiler warning on ARM:
> 
> drivers/gpu/drm/virtio/virtgpu_fence.c: In function 'virtio_timeline_value_str':
> drivers/gpu/drm/virtio/virtgpu_fence.c:64:22: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat=]
>   snprintf(str, size, "%lu", atomic64_read(&fence->drv->last_seq));
>                       ^
> drivers/gpu/drm/virtio/virtgpu_debugfs.c: In function 'virtio_gpu_debugfs_irq_info':
> drivers/gpu/drm/virtio/virtgpu_debugfs.c:37:16: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'long long int' [-Wformat=]
>   seq_printf(m, "fence %ld %lld\n",
>                 ^
> 
> In order to avoid the warnings, this changes the format strings to %llu
> and adds a cast to u64, which makes it work the same way everywhere.

You have to wonder why atomic64_* functions do not use u64 types.
If they're not reliant on manipulating 64-bit quantities, then what's
the point of calling them atomic _64_.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
