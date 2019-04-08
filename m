From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] virtio_blk: replace 0 by HCTX_TYPE_DEFAULT to index
	blk_mq_tag_set->map
Date: Mon, 8 Apr 2019 08:08:39 -0600
Message-ID: <22ed96be-fa8c-a30b-980c-9777afbfcae6__33988.6471790791$1554732535$gmane$org@kernel.dk>
References: <1552354316-20204-1-git-send-email-dongli.zhang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1552354316-20204-1-git-send-email-dongli.zhang@oracle.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dongli Zhang <dongli.zhang@oracle.com>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 3/11/19 7:31 PM, Dongli Zhang wrote:
> Use HCTX_TYPE_DEFAULT instead of 0 to avoid hardcoding.

Applied, thanks.

-- 
Jens Axboe
