From: Linhaifeng <haifeng.lin@huawei.com>
Subject: Re: virtio-net: tx queue was stopped
Date: Fri, 20 Mar 2015 17:23:17 +0800
Message-ID: <550BE705.4050806__36423.1865191416$1426871638$gmane$org@huawei.com>
References: <55052BB3.2080705@huawei.com>
	<20150315080138-mutt-send-email-mst@redhat.com>
	<5506A137.8050909@huawei.com>
	<20150316132309-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150316132309-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, lilijun <jerry.lilijun@huawei.com>, virtualization@lists.linux-foundation.org, "liuyongan@huawei.com" <liuyongan@huawei.com>, "lixiao (H)" <lixiao91@huawei.com>
List-Id: virtualization@lists.linuxfoundation.org



On 2015/3/16 20:26, Michael S. Tsirkin wrote:
> Host just needs to be spec-compliant.
> It must send interrupts unless they are disabled.
> So this sounds like a VHOST_F_FIX_A_BUG to me. Just fix races in
> vhost-user code, and no need for extra flags.

Michael,

Thank you for your suggestion.
I will fix races in vhost-user's code.

-- 
Regards,
Haifeng
