From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 16/17] add kmap_atomic_pte for mapping highpte pages
Date: Mon, 02 Apr 2007 00:22:29 -0700
Message-ID: <4610AF35.9090406@goop.org>
References: <20070402055652.610711908@goop.org>
	<20070402055705.499213579@goop.org> <200704020918.20008.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704020918.20008.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> +}
>> +
>> +/* Flush all unused kmap mappings in order to remove stray
>> +   mappings. */
>> +void kmap_flush_unused(void)
>> +{
>> +	spin_lock(&kmap_lock);
>> +	flush_all_zero_pkmaps();
>> +	spin_unlock(&kmap_lock);
>>  }
>>     =

>
> Who calls this now?

Nobody in kernel, or in this patchset.  The Xen code calls it to make
sure there are no stray RW mappings of a page it has freshly allocated
for use in a pagetable.

    J
