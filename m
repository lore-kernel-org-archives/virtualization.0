From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [RFC 0/2] virtio: provide a way for host to monitor critical
	events in the device
Date: Tue, 24 Jul 2012 14:26:33 +0200
Message-ID: <500E9479.3050405__4822.34985470331$1343132787$gmane$org@gmail.com>
References: <1343075561-29316-1-git-send-email-levinsasha928@gmail.com>
	<20120724074434.GE26120@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120724074434.GE26120@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: wency@cn.fujitsu.com, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, penberg@kernel.org, avi@redhat.com, anthony@codemonkey.ws
List-Id: virtualization@lists.linuxfoundation.org

On 07/24/2012 09:44 AM, Gleb Natapov wrote:
> On Mon, Jul 23, 2012 at 10:32:39PM +0200, Sasha Levin wrote:
>> As it was discussed recently, there's currently no way for the guest to notify
>> the host about panics. Further more, there's no reasonable way to notify the
>> host of other critical events such as an OOM kill.
>>
>> This short patch series introduces a new device named virtio-notifier which
>> does two simple things:
>>
>>  1. Provide a simple interface for the guest to notify the host of critical
> To get early OOPSes virtio will have to be compiled into the kernel. If
> your are so keen on using virtio for this though, why not just use
> dedicated virtio serial channel?

Let's separate between having log for these events and receiving notifications about them.

For the log part, I can already run a simple serial console to dump everything somewhere. I'm more concerned about having notifications about something critical happening when the guest is already up and running.
