From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/3] Split the KVM pv-ops support by feature
Date: Wed, 18 Nov 2009 02:37:28 +0100
Message-ID: <4E096C66-A234-48F2-80D5-82D735CF5715__15061.8962631144$1258508351$gmane$org@suse.de>
References: <1258503192-14246-1-git-send-email-agraf@suse.de>
	<1258503192-14246-4-git-send-email-agraf@suse.de>
	<200911181203.39955.rusty@rustcorp.com.au>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200911181203.39955.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Nick Piggin <npiggin@suse.de>, kvm list <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On 18.11.2009, at 02:33, Rusty Russell wrote:

> On Wed, 18 Nov 2009 10:43:12 am Alexander Graf wrote:
>> Currently selecting KVM guest support enabled multiple features at  
>> once that
>> not everyone necessarily wants to have, namely:
>
> These patches make perfect sense, but please make sure Jeremy  
> Fitzhardinge
> (CC'd) is in the loop, as he split the structs in the first place.

Oh sure, if you know other people I should CC please tell me the mail  
addresses too :-).

Jeremy, did you get the patchset? I can send it to you if you're not  
subscribed to virtualization@.


Alex
