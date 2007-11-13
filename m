From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [kvm-devel] [PATCH 0/24] paravirt_ops for unified x86 - that's
 me again!
Date: Tue, 13 Nov 2007 09:43:34 -0200
Message-ID: <47398DE6.6000309__5082.86694898761$1194954231$gmane$org@redhat.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<200711121347.20050.amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200711121347.20050.amit.shah@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@qumranet.com>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, ak@suse.de, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Amit Shah escreveu:
> On Saturday 10 November 2007 00:12:41 Glauber de Oliveira Costa wrote:
>> Hey folks,
>>
>> Here's a new spin of the pvops64 patch series.
>> We didn't get that many comments from the last time,
>> so it should be probably almost ready to get in. Heya!
>>
>> >From the last version, the most notable changes are:
>>
>> * consolidation of system.h, merging jeremy's comments about ordering
>>   concerns
>> * consolidation of smp functions that goes through smp_ops. They're sharing
>>   a bunch of code now.
>>
>> Other than that, just some issues that arose from the rebase.
>>
>> Please, not that this patch series _does not_ apply over linus git anymore,
>> but rather, over tglx cleanup series.
>>
>> The first patch in this series is already on linus', but not on tglx', so
>> I'm sending it again, because you'll need it if you want to compile it
>> anyway.
>>
>> tglx, in the absense of any outstanding NACKs, or any very big call for
>> improvements, could you please pull it in your tree?
>>
>> Have fun,
> 
> Glauber, are you planning on consolidating the dma_ops structure for 32- and 
> 64-bit? 32-bit doesn't currently have a dma_mapping_ops structure, which 
> makes paravirtualizing DMA access difficult on 32-bit.
Until its get merged, definitely not. Although important, this is
significant work, and can delay us even more. But I was not planning to
do it at all (well, you were the first that raised the issue...)

So if the reason for your question is you are planning to work on it, go
ahead ;-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Remi - http://enigmail.mozdev.org

iD8DBQFHOY3mjYI8LaFUWXMRAvnqAJ4ridsG0ZB2aI7U36hbZFBO0PoDgQCgqvjc
n6RbVz7Jw8t9qCyKUN+hLGg=
=crYj
-----END PGP SIGNATURE-----
