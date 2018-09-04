From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost: fix VHOST_GET_BACKEND_FEATURES ioctl request
	definition
Date: Mon, 03 Sep 2018 21:23:43 -0700 (PDT)
Message-ID: <20180903.212343.355534384554181027.davem__36127.7248980061$1536034906$gmane$org@davemloft.net>
References: <20180903222127-mutt-send-email-mst@kernel.org>
	<a9ea89ac-4816-96a1-7de4-caf9884da876@redhat.com>
	<20180903231102-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180903231102-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, glebfm@altlinux.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 3 Sep 2018 23:11:11 -0400

> On Tue, Sep 04, 2018 at 11:08:40AM +0800, Jason Wang wrote:
>> 
>> 
>> On 2018年09月04日 10:22, Michael S. Tsirkin wrote:
>> > On Mon, Sep 03, 2018 at 08:59:13PM +0300, Gleb Fotengauer-Malinovskiy wrote:
>> > > The _IOC_READ flag fits this ioctl request more because this request
>> > > actually only writes to, but doesn't read from userspace.
>> > > See NOTEs in include/uapi/asm-generic/ioctl.h for more information.
>> > > 
>> > > Fixes: 429711aec282 ("vhost: switch to use new message format")
>> > > Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
>> > Hmm it does make sense, and it's not too late to fix this up.
>> > Jason, what's your take on this? Was _IOW intentional?
>> 
>> My bad, not intentional. And I agree that fixing this is not too late.
>> 
>> So
>> 
>> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> 
> OK then
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thanks everyone.
