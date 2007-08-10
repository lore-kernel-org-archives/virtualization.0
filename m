From: Avi Kivity <avi@qumranet.com>
Subject: Re: 2.6.22 x86_64 : kernel initial decompression hangs on vmware
Date: Fri, 10 Aug 2007 04:48:06 +0300
Message-ID: <46BBC3D6.902@qumranet.com>
References: <46A7E606.4030001@oxeva.fr> <46B4A7E4.4030907@vmware.com> <46BB7FCC.4040509@qumranet.com> <46BBA310.6060706@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765748AbXHJBsc@vger.kernel.org>
In-Reply-To: <46BBA310.6060706@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Gabriel Barazer <gabriel@oxeva.fr>, Andi Kleen <ak@suse.de>, Jim Mattson <jmattson@vmware.com>, linux-kernel@vger.kernel.org, Virtualization Mailing List <virtualization@lists.osdl.org>, kvm-devel <kvm-devel@lists.sourceforge.net>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Avi Kivity wrote:
>>
>> We haven't seen any issue with the 2.6.22 boot decompressor.  Which 
>> of the four (fs, gs, ldt, or tr) were proving problematic and why?
>
> It was tr that was affecting Workstation, since we boot through normal 
> BIOS path, and only a 16-bit task was loaded at this point.
>

Ah.  Maybe we didn't have an exit while we were in long mode with the 
16-bit tss, so VT didn't notice the illegal combination.
