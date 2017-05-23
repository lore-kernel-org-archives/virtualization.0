From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 00/10] paravirt: make amount of paravirtualization
	configurable
Date: Tue, 23 May 2017 08:27:09 +0200
Message-ID: <97eae032-a5d8-b463-b81a-ce0375ea8e26@suse.com>
References: <20170519154746.29389-1-jgross@suse.com>
	<0bd6745b-9483-4d95-53d5-f13288f4c629@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0bd6745b-9483-4d95-53d5-f13288f4c629@oracle.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On 22/05/17 21:42, Boris Ostrovsky wrote:
> 
>>  49 files changed, 1548 insertions(+), 1477 deletions(-)
>>  create mode 100644 arch/x86/include/asm/paravirt_full.h
>>  create mode 100644 arch/x86/include/asm/paravirt_types_full.h
>>  create mode 100644 arch/x86/kernel/paravirt_full.c
> 
> 
> Do you have this in a tree that can be pulled?

https://github.com/jgross1/linux pvops


Juergen
