From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] virtio: expose for non-virtualization users too
Date: Tue, 05 Jul 2011 15:35:46 -0700
Message-ID: <4E1391C2.2090904__24845.9946633831$1309905478$gmane$org@zytor.com>
References: <1309874774-31689-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1309874774-31689-1-git-send-email-ohad@wizery.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Carsten Otte <cotte@de.ibm.com>, linux-ia64@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Grant Likely <grant.likely@secretlab.ca>, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, Chris Metcalf <cmetcalf@tilera.com>, John Stultz <john.stultz@linaro.org>, kvm-ppc@vger.kernel.org, Thomas Gleixner <tglx@linutronix>
List-Id: virtualization@lists.linuxfoundation.org

On 07/05/2011 07:06 AM, Ohad Ben-Cohen wrote:
> virtio has been so far used only in the context of virtualization,
> and the virtio Kconfig was sourced directly by the relevant arch
> Kconfigs when VIRTUALIZATION was selected.
> 
> Now that we start using virtio for inter-processor communications,
> we need to source the virtio Kconfig outside of the virtualization
> scope too.
> 

Seems reasonable to me.

	-hpa
