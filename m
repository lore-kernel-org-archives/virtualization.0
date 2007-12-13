From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 0/19 -v4] desc_struct integration
Date: Thu, 13 Dec 2007 15:06:46 -0200
Message-ID: <476166A6.8070304__44346.5529395782$1197565790$gmane$org@redhat.com>
References: <11975113122984-git-send-email-gcosta@redhat.com>
	<1197554287294-git-send-email-gcosta@redhat.com>
	<20071213164701.GB4865@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071213164701.GB4865@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Glauber de Oliveira Costa <gcosta@redhat.com> wrote:
> 
>> Since the last version of it received no comments on the interfaces, 
>> here it goes a version, that I feel ready for inclusion.
>>
>> The comments regarding style, specially the elimination of the 
>> #defines in the desc_struct definition were merged. I also implemented 
>> the vmi functions, missing last time.
>>
>> Ingo, in the absense of further complaints, could you please push to 
>> the x86 tree?
> 
> well i've already included v3 in x86.git (and it's pushed out), and that 
> was looking good already in review and in testing - could you send a 
> v3->v4 delta too?
Sure. The only real difference was Andi suggestion, but it was more 
stylish. Will do soon.
