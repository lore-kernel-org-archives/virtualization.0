From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm balloon: umount balloon_mnt when remove vb device
Date: Thu, 9 Feb 2017 08:42:15 +0900
Message-ID: <20170208234215.GB16728__30779.6888206669$1486598246$gmane$org@bbox>
References: <1486531318-35189-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1486531318-35189-1-git-send-email-xieyisheng1@huawei.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: aquini@redhat.com, mst@redhat.com, vbabka@suse.cz, liubo95@huawei.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, gi-oh.kim@profitbricks.com, guohanjun@huawei.com, qiuxishi@huawei.com, akpm@linux-foundation.org, mhocko@kernel.org, koct9i@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 08, 2017 at 01:21:58PM +0800, Yisheng Xie wrote:
> With CONFIG_BALLOON_COMPACTION=y, it will mount balloon_mnt for
> balloon page migration when probe a virtio_balloon device, however
> do not unmount it when remove the device, fix it.
> 
> Fixes: b1123ea6d3b3 ("mm: balloon: use general non-lru movable page feature")
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

Thanks for the fixing!

Acked-by: Minchan Kim <minchan@kernel.org>
