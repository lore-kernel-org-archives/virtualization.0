From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 3/21] [PATCH] move desc_empty to where they belong
Date: Tue, 18 Dec 2007 10:03:27 -0200
Message-ID: <4767B70F.1050403__35845.2619672336$1197979582$gmane$org@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
	<200712181614.37890.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712181614.37890.rusty@rustcorp.com.au>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Tuesday 18 December 2007 09:52:26 Glauber de Oliveira Costa wrote:
>> +static inline int desc_empty(const void *ptr)
>> +{
>> +	const u32 *desc = ptr;
>> +	return !(desc[0] | desc[1]);
>> +}
> 
> Erk. This really needs to be a union, not a void *.  I guess we can clean it 
> later.
> 
> Rusty.
My last series, that unified desc_struct, made it possible to do that.
However, the intent of this, is just move it to a common place.
