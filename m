From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 2/3] virtio: rng: delay hwrng_register() till driver is
	ready
Date: Mon, 21 Jul 2014 16:40:27 +0530
Message-ID: <20140721111027.GA12925@grmbl.mre>
References: <cover.1405934853.git.amit.shah@redhat.com>
	<9a28f933ee53b9dce40791988d811011f0aaf8e7.1405934853.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9a28f933ee53b9dce40791988d811011f0aaf8e7.1405934853.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: jason@lakedaemon.net, keescook@chromium.org, Virtualization List <virtualization@lists.linux-foundation.org>, herbert@gondor.apana.org.au
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 21 Jul 2014 [15:01:00], Amit Shah wrote:
> Instead of calling hwrng_register() in the probe routing, call it in the
> scan routine.  This ensures that when hwrng_register() is successful,
> and it requests a few random bytes to seed the kernel's pool at init,
> we're ready to service that request.
> 
> This will also enable us to remove the workaround added previously to
> check whether probe was completed, and only then ask for data from the
> host.  The revert follows in the next commit.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  drivers/char/hw_random/virtio-rng.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index d8ffebd..32e6373 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -38,6 +38,7 @@ struct virtrng_info {
>  };
>  
>  static bool probe_done;
> +static bool hwrng_register_done;

Ah; this needs to be per-device after the recent multi-device work,
rather than a global.

New patches coming up.


		Amit
