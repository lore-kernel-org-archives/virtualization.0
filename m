From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Jul 21 (gpu/virtio)
Date: Thu, 21 Jul 2016 09:21:44 -0700
Message-ID: <eae4bce5-3624-7ef7-f6b8-ca2c3caad2d0__27347.5503352985$1469118129$gmane$org@infradead.org>
References: <20160721165631.6508756a@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160721165631.6508756a@canb.auug.org.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07/20/16 23:56, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20160720:
> 

on x86_64, when CONFIG_FB is not enabled:

ERROR: "remove_conflicting_framebuffers" [drivers/gpu/drm/virtio/virtio-gpu.ko] undefined!


-- 
~Randy
