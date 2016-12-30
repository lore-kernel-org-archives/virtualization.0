From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] virtio-crypto: support crypto engine framework
Date: Fri, 30 Dec 2016 20:20:52 +0800
Message-ID: <20161230122052.GH15832__41584.4190087684$1483100494$gmane$org@gondor.apana.org.au>
References: <1482821347-47664-1-git-send-email-arei.gonglei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1482821347-47664-1-git-send-email-arei.gonglei@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gonglei <arei.gonglei@huawei.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org, longpeng2@huawei.com, wu.wubin@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 27, 2016 at 02:49:07PM +0800, Gonglei wrote:
> crypto engine was introduced since 'commit 735d37b5424b ("crypto: engine
> - Introduce the block request crypto engine framework")' which uses work
> queue to realize the asynchronous processing for ablk_cipher and ahash.
> 
> For virtio-crypto device, I register an engine for each
> data virtqueue so that we can use the capability of
> multiple data queues in future.
> 
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
