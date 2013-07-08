From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] xen: remove unused Kconfig parameter
Date: Mon, 08 Jul 2013 13:13:01 -0700
Message-ID: <51DB1D4D.7030308@zytor.com>
References: <1373264904-27053-1-git-send-email-michael.opdenacker@free-electrons.com>
	<20130708192854.GF4927@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130708192854.GF4927@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Michael Opdenacker <michael.opdenacker@free-electrons.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On 07/08/2013 12:28 PM, Konrad Rzeszutek Wilk wrote:
> On Mon, Jul 08, 2013 at 08:28:24AM +0200, Michael Opdenacker wrote:
>> This patch proposes to remove the XEN_PRIVILEGED_GUEST kernel
>> configuration parameter defined in arch/x86/xen/Kconfig, but used
>> nowhere in the makefiles and source code.
>>
>> This dummy parameter was added 3 years back, and it may
>> make sense to remove it now, as the reasons to use it were not
>> very clear.
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> 
> Can't remove it. It is used by grub2.
> 

What the fsck does grub2 have to do with Kconfig?

	-hpa
