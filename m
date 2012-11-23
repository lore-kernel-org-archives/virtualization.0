From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
Date: Thu, 22 Nov 2012 17:34:56 -0800
Message-ID: <a1f75604-1f52-4af1-9dd7-b469ed4ea7b6@email.android.com>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
	<1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
	<87lidwtego.fsf@xmission.com>
	<20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
	<87txshx28b.fsf@xmission.com> <50AE6542.3020302@zytor.com>
	<50AEBF86.50501@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50AEBF86.50501@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Ok... that *sort of* makes sense, but also underscores how utterly different this is from a normal kexec.

Andrew Cooper <andrew.cooper3@citrix.com> wrote:

>On 22/11/2012 17:47, H. Peter Anvin wrote:
>> The other thing that should be considered here is how utterly 
>> preposterous the notion of doing in-guest crash dumping is in a
>system 
>> that contains a hypervisor.  The reason for kdump is that on bare
>metal 
>> there are no other options, but in a hypervisor system the right
>thing 
>> should be for the hypervisor to do the dump (possibly spawning a
>clean 
>> I/O domain if the I/O domain is necessary to access the media.)
>>
>> There is absolutely no reason to have a crashkernel sitting around in
>
>> each guest, consuming memory, and possibly get corrupt.
>>
>> 	-hpa
>>
>
>(Your reply to my email which I can see on the xen devel archive
>appears
>to have gotten lost somewhere inside the citrix email system, so
>apologies for replying out of order)
>
>The kdump kernel loaded by dom0 is for when Xen crashes, not for when
>dom0 crashes (although a dom0 crash does admittedly lead to a Xen
>crash)
>
>There is no possible way it could be a separate domain; Xen completely
>ceases to function as soon as jumps to the entry point of the kdump
>image.
>
>~Andrew

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
