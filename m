From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v3 2/2] virtio_balloon: replace oom notifier with shrinker
Date: Fri, 3 Aug 2018 21:11:09 +0900
Message-ID: <16c56ee5-eef7-dd5f-f2b6-e3c11df2765c__48600.032614968$1533298162$gmane$org@i-love.sakura.ne.jp>
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
	<1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 2018/08/03 17:32, Wei Wang wrote:
> +static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
> +{
> +	vb->shrinker.scan_objects = virtio_balloon_shrinker_scan;
> +	vb->shrinker.count_objects = virtio_balloon_shrinker_count;
> +	vb->shrinker.batch = 0;
> +	vb->shrinker.seeks = DEFAULT_SEEKS;

Why flags field is not set? If vb is allocated by kmalloc(GFP_KERNEL)
and is nowhere zero-cleared, KASAN would complain it.

> +
> +	return register_shrinker(&vb->shrinker);
> +}
