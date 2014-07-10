From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v3 1/2] hwrng: fetch randomness only after device init
Date: Thu, 10 Jul 2014 07:13:38 -0400
Message-ID: <20140710111338.GR13433@titan.lakedaemon.net>
References: <cover.1404987133.git.amit.shah@redhat.com>
	<8cf671af94c4747765ebec91a2a4f034a65aef2e.1404987133.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8cf671af94c4747765ebec91a2a4f034a65aef2e.1404987133.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, keescook@chromium.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 10, 2014 at 03:42:34PM +0530, Amit Shah wrote:
> Commit d9e7972619334 "hwrng: add randomness to system from rng sources"
> added a call to rng_get_data() from the hwrng_register() function.
> However, some rng devices need initialization before data can be read
> from them.
> 
> This commit makes the call to rng_get_data() depend on no init fn
> pointer being registered by the device.  If an init function is
> registered, this call is made after device init.
> 
> CC: Kees Cook <keescook@chromium.org>
> CC: Jason Cooper <jason@lakedaemon.net>
> CC: Herbert Xu <herbert@gondor.apana.org.au>
> CC: <stable@vger.kernel.org> # For v3.15+
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  drivers/char/hw_random/core.c | 41 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)

Reviewed-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
