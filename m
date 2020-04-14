From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 40/70] x86/sev-es: Setup per-cpu GHCBs for the runtime
 handler
Date: Tue, 14 Apr 2020 13:12:56 -0700
Message-ID: <fbc91dfc-7851-c7d8-ccdb-16c014526801@intel.com>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-41-joro@8bytes.org>
 <A7DF63B4-6589-4386-9302-6B7F8BE0D9BA@vmware.com>
 <09757a84-1d81-74d5-c425-cff241f02ab9@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <09757a84-1d81-74d5-c425-cff241f02ab9@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Tom Lendacky <thomas.lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On 4/14/20 1:04 PM, Tom Lendacky wrote:
>> set_memory_decrypted needs to check the return value. I see it
>> consistently return ENOMEM. I've traced that back to split_large_page
>> in arch/x86/mm/pat/set_memory.c.
> 
> At that point the guest won't be able to communicate with the
> hypervisor, too. Maybe we should BUG() here to terminate further
> processing?

Escalating an -ENOMEM into a crashed kernel seems a bit extreme.
Granted, the guest may be in an unrecoverable state, but the host
doesn't need to be too.
