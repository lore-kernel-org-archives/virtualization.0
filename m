From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/10] add missing parameter for lookup_address
Date: Sat, 19 Jan 2008 02:16:09 +0100
Message-ID: <20080119011609.GA15614__22020.7391227179$1200706069$gmane$org@bingen.suse.de>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<12006768362108-git-send-email-gcosta@redhat.com>
	<20080118202613.GY3627@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080118202613.GY3627@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 18, 2008 at 12:26:13PM -0800, Chris Wright wrote:
> * Glauber de Oliveira Costa (gcosta@redhat.com) wrote:
> > lookup_address() receives two parameters, but efi_64.c call
> > is passing only one. It's actually preventing the tree from compiling
> > 
> > Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
> 
> Good catch, I know I don't test with CONFIG_EFI=y

Ah that came probably from the CPA patchset which added the parameter.
Sorry for that.

-Andi
