From: Dor Laor <dlaor@redhat.com>
Subject: Re: [PATCH v4 00/12] virtio: s4 support
Date: Wed, 07 Dec 2011 15:43:02 +0200
Message-ID: <4EDF6D66.5030003@redhat.com>
References: <cover.1323199985.git.amit.shah@redhat.com>
	<87wra8j13m.fsf@rustcorp.com.au>
	<20111207104459.GR12507@redhat.com>
Reply-To: dlaor@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111207104459.GR12507@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, levinsasha928@gmail.com, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12/07/2011 12:44 PM, Gleb Natapov wrote:
> On Wed, Dec 07, 2011 at 05:54:29PM +1030, Rusty Russell wrote:
>> On Wed,  7 Dec 2011 01:18:38 +0530, Amit Shah<amit.shah@redhat.com>  wrote:
>>> Hi,
>>>
>>> These patches add support for S4 to virtio (pci) and all drivers.
>>
>> Dumb meta-question: why do we want to hibernate virtual machines?
>>
> For instance you want to hibernate your laptop while it is running a virtual
> machine. You can pause them of course, but then time will be incorrect
> inside a guest after resume.

Exactly. Today with do that through live migration into a file, we call 
it external hibernation. The problem that it is transparent from the 
guest and thus it loses time keeping. Even NTP can't handle it since if 
it has more than 0.5% delay it stops syncing.

The solution is to do it through s4 where the guest gets a notification 
when it resumes.


>
>> I figure there's a reason, but it seems a bit weird :)
>>
>> Thanks,
>> Rusty.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
> --
> 			Gleb.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
