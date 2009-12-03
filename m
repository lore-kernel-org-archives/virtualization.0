From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/3] Split up pv-ops
Date: Thu, 03 Dec 2009 17:00:32 +0200
Message-ID: <4B17D290.9040507__41726.9659381875$1259852478$gmane$org@redhat.com>
References: <1258503192-14246-1-git-send-email-agraf@suse.de>
	<4B17D0C7.1020805@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B17D0C7.1020805@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Nick Piggin <npiggin@suse.de>, Glauber Costa <glommer@redhat.com>, kvm list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 12/03/2009 04:52 PM, Alexander Graf wrote:
> Alexander Graf wrote:
>    
>> Paravirt ops is currently only capable of either replacing a lot of Linux
>> internal code or none at all. The are users that don't need all of the
>> possibilities pv-ops delivers though.
>>
>> On KVM for example we're perfectly fine not using the PV MMU, thus not
>> touching any MMU code. That way we don't have to improve pv-ops to become
>> fast, we just don't compile the MMU parts in!
>>
>> This patchset splits pv-ops into several smaller config options split by
>> feature category and then converts the KVM pv-ops code to use only the
>> bits that are required, lowering overhead.
>>
>>      
> So has this ended up in some tree yet?
>    

Don't think so.  I suggest you copy lkml and Ingo.

-- 
error compiling committee.c: too many arguments to function
