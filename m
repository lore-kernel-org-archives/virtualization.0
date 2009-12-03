From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/3] Split up pv-ops
Date: Thu, 03 Dec 2009 17:07:48 +0200
Message-ID: <4B17D444.6060702__3330.53323342956$1259852962$gmane$org@redhat.com>
References: <1258503192-14246-1-git-send-email-agraf@suse.de>
	<4B17D0C7.1020805@suse.de> <4B17D290.9040507@redhat.com>
	<4B17D390.5050602@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B17D390.5050602@suse.de>
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

On 12/03/2009 05:04 PM, Alexander Graf wrote:
>> Don't think so.  I suggest you copy lkml and Ingo.
>>      
> Sending off the complete set again?

Yes.

> Rebased against what?
>    

tip's x86/paravirt seems like a good choice (though only one patch is in 
there at present).

-- 
error compiling committee.c: too many arguments to function
