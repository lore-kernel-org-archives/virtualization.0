From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
	vmap()
Date: Sat, 15 Dec 2018 11:43:08 -0800 (PST)
Message-ID: <20181215.114308.647436101869587689.davem__29777.7008651339$1544902867$gmane$org@davemloft.net>
References: <20181213101022.12475-1-jasowang@redhat.com>
	<20181213144116-mutt-send-email-mst@kernel.org>
	<836932fc-9266-b73d-2ee5-645f399e1a54@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <836932fc-9266-b73d-2ee5-645f399e1a54@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Dec 2018 12:29:54 +0800

> 
> On 2018/12/14 上午4:12, Michael S. Tsirkin wrote:
>> On Thu, Dec 13, 2018 at 06:10:19PM +0800, Jason Wang wrote:
>>> Hi:
>>>
>>> This series tries to access virtqueue metadata through kernel virtual
>>> address instead of copy_user() friends since they had too much
>>> overheads like checks, spec barriers or even hardware feature
>>> toggling.
>>>
>>> Test shows about 24% improvement on TX PPS. It should benefit other
>>> cases as well.
>>>
>>> Please review
>> I think the idea of speeding up userspace access is a good one.
>> However I think that moving all checks to start is way too aggressive.
> 
> 
> So did packet and AF_XDP. Anyway, sharing address space and access
> them directly is the fastest way. Performance is the major
> consideration for people to choose backend. Compare to userspace
> implementation, vhost does not have security advantages at any
> level. If vhost is still slow, people will start to develop backends
> based on e.g AF_XDP.

Exactly, this is precisely how this kind of problem should be solved.

Michael, I strongly support the approach Jason is taking here, and I
would like to ask you to seriously reconsider your objections.

Thank you.
