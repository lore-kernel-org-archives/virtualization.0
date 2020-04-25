From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Date: Sat, 25 Apr 2020 14:28:35 +0200
Message-ID: <20200425122835.GM30814@suse.de>
References: <20200319091407.1481-56-joro@8bytes.org>
 <20200424210316.848878-1-mstunes@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200424210316.848878-1-mstunes@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Stunes <mstunes@vmware.com>
Cc: joro@8bytes.org, dan.j.williams@intel.com, dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com, jslaby@suse.cz, keescook@chromium.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, thellstrom@vmware.com, thomas.lendacky@amd.com, virtualization@lists.linux-foundation.org, x86@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Mike,

On Fri, Apr 24, 2020 at 02:03:16PM -0700, Mike Stunes wrote:
> I needed to allow RDTSC(P) from userspace and in early boot in order to
> get userspace started properly. Patch below.

Thanks, but this is not needed anymore. I removed the vc_context_filter
from the code. The emulation code is now capable of safely handling any
exception from user-space.

Regards,

	Joerg
