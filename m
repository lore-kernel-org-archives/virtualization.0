From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] virtio-blk: free vblk-vqs in error path of
 virtblk_probe()
Date: Tue, 30 Jun 2020 19:03:30 -0600
Message-ID: <daba0f31-df05-0d1f-9422-15c6813f62af@kernel.dk>
References: <20200615041459.22477-1-houtao1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200615041459.22477-1-houtao1@huawei.com>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ming Lei <ming.lei@canonical.com>
List-Id: virtualization@lists.linuxfoundation.org

On 6/14/20 10:14 PM, Hou Tao wrote:
> Else there will be memory leak if alloc_disk() fails.

Applied, thanks.

-- 
Jens Axboe
