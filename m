From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2] virtio-crypto: adjust priority of algorithm
Date: Fri, 13 Jan 2017 22:37:42 +0800
Message-ID: <20170113143742.GD26101__9974.3394334384$1484318283$gmane$org@gondor.apana.org.au>
References: <1484300056-35284-1-git-send-email-arei.gonglei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1484300056-35284-1-git-send-email-arei.gonglei@huawei.com>
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
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 13, 2017 at 05:34:16PM +0800, Gonglei wrote:
> Some hardware accelerators (like intel aesni or the s390
> cpacf functions) have lower priorities than virtio
> crypto, and those drivers are faster than the same in
> the host via virtio. So let's lower the priority of
> virtio-crypto's algorithm, make it's higher than software
> implementations but lower than the hardware ones.
> 
> Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
