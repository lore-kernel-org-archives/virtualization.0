From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: Update spec address
Date: Tue, 3 Dec 2013 14:55:05 +0200
Message-ID: <20131203125505.GA32687@redhat.com>
References: <1386074421-20662-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1386074421-20662-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 03, 2013 at 12:40:21PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> According to the README at the existing URL the spec has moved to github
> so update the documentation to match.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Even that's no longer accurate :)
There should be a new address RSN, I'll respond.

> ---
>  Documentation/devicetree/bindings/virtio/mmio.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.txt b/Documentation/devicetree/bindings/virtio/mmio.txt
> index 5069c1b8e193..0648851d2a25 100644
> --- a/Documentation/devicetree/bindings/virtio/mmio.txt
> +++ b/Documentation/devicetree/bindings/virtio/mmio.txt
> @@ -1,6 +1,6 @@
>  * virtio memory mapped device
>  
> -See http://ozlabs.org/~rusty/virtio-spec/ for more details.
> +See https://github.com/rustyrussell/virtio-spec for more details.
>  
>  Required properties:
>  
> -- 
> 1.8.5
