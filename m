From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: [PATCH 1/2] rngd: add udev rule to source from hwrng if virtio-rng
	present
Date: Thu, 07 Aug 2014 12:31:11 -0700
Message-ID: <53E3D3FF.70707__21470.0099583299$1407440547$gmane$org@linux.intel.com>
References: <cover.1407416628.git.amit.shah@redhat.com>
	<dd2ddb8458e5ab5cffceb7fac2e3f71e9e2197f3.1407416628.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <dd2ddb8458e5ab5cffceb7fac2e3f71e9e2197f3.1407416628.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, jgarzik@bitpay.com
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/07/2014 06:08 AM, Amit Shah wrote:
> On KVM guests where the virtio-rng device is available, and set as the
> current rng, this udev rule will start rngd which will feed in the
> host-provided entropy to /dev/random.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  90-virtio-rng.rules | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 90-virtio-rng.rules
> 
> diff --git a/90-virtio-rng.rules b/90-virtio-rng.rules
> new file mode 100644
> index 0000000..07f2f9c
> --- /dev/null
> +++ b/90-virtio-rng.rules
> @@ -0,0 +1 @@
> +KERNEL=="hw_random", ATTR{rng_current}=="virtio*", RUN+="/sbin/rngd -r /dev/hwrng"
> 

I'm not sure this is really right.  rngd can receive input from a number
of sources, and I suspect it would be better to rngd to be started much
earlier and perhaps get sent a SIGHUP to reconfigure when a hw_random
device appears ... not just the virtio one.

Currently rngd exits if there is no daemon.  There are a few ways to
deal with that: one is to run rngd on changes and leave a pid file
around; the rngd can try to signal the old rngd or launch itself;
another option would be to have a different rngd for each source.  To
some degree the above is obsolete when we get khwrngd widely deployed,
but that is a new-kernel-only kind of thing.

	-hpa
