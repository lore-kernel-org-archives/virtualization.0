From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost: validate log when IOTLB is enabled
Date: Thu, 29 Mar 2018 16:23:12 -0400 (EDT)
Message-ID: <20180329.162312.1243047104828828329.davem__26007.3874415413$1522354899$gmane$org@davemloft.net>
References: <1522310404-8486-1-git-send-email-jasowang@redhat.com>
	<20180329154803-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180329154803-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 29 Mar 2018 15:48:22 +0300

> On Thu, Mar 29, 2018 at 04:00:04PM +0800, Jason Wang wrote:
>> Vq log_base is the userspace address of bitmap which has nothing to do
>> with IOTLB. So it needs to be validated unconditionally otherwise we
>> may try use 0 as log_base which may lead to pin pages that will lead
>> unexpected result (e.g trigger BUG_ON() in set_bit_to_user()).
>> 
>> Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
>> Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> stable material I guess.

Applied and queued up for -stable.
