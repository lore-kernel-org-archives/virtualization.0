From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next V4 0/5] vhost: accelerate metadata access
	through vmap()
Date: Sat, 26 Jan 2019 14:37:08 -0800 (PST)
Message-ID: <20190126.143708.1203048880266877709.davem__11173.2646169671$1548596130$gmane$org@davemloft.net>
References: <20190123095557.30168-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190123095557.30168-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Jan 2019 17:55:52 +0800

> This series tries to access virtqueue metadata through kernel virtual
> address instead of copy_user() friends since they had too much
> overheads like checks, spec barriers or even hardware feature
> toggling.
> 
> Test shows about 24% improvement on TX PPS. It should benefit other
> cases as well.

I've read over the discussion of patch #5 a few times.

And it seems to me that, at a minimum, a few things still need to
be resolved:

1) More perf data added to commit message.

2) Whether invalidate_range_start() and invalidate_range_end() must
   be paired.

Etc.  So I am marking this series "Changes Requested".
