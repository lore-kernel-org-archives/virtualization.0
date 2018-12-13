From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] vhost: correct the related warning message
Date: Thu, 13 Dec 2018 12:05:31 +0300
Message-ID: <7c1a2b4c-670f-2be8-88e1-7485237029f6@cogentembedded.com>
References: <5C11B176.4040704@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5C11B176.4040704@huawei.com>
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
To: wangyan <wangyan122@huawei.com>, mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, piaojun <piaojun@huawei.com>, viro@zeniv.linux.org.uk, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On 13.12.2018 4:10, wangyan wrote:

> Fixes: 'commit d588cf8f618d ("target: Fix se_tpg_tfo->tf_subsys regression + remove tf_subsystem")'
>         'commit cbbd26b8b1a6 ("[iov_iter] new primitives - copy_from_iter_full() and friends")'

Fixes: d588cf8f618d ("target: Fix se_tpg_tfo->tf_subsys regression + remove 
tf_subsystem")
Fixes: cbbd26b8b1a6 ("[iov_iter] new primitives - copy_from_iter_full() and 
friends")

    But no line wrapping allowed (can't find how to turn it off in my mailer).

> Signed-off-by: Yan Wang <wangyan122@huawei.com>
> Reviewed-by: Jun Piao <piaojun@huawei.com>
[...]

MBR, Sergei
