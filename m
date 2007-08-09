From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: Introducing paravirt_ops for x86_64
Date: Wed, 8 Aug 2007 21:31:17 -0300
Message-ID: <5d6222a80708081731y4e20e0a4oedc27e0766283b6a__2841.01561778716$1186619588$gmane$org@mail.gmail.com>
References: <5d6222a80708080758t1b937d0ej14c5e60ac23a20c5@mail.gmail.com>
	<97D612E30E1F88419025B06CB4CF1BE10326E924@scsmsx412.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <97D612E30E1F88419025B06CB4CF1BE10326E924@scsmsx412.amr.corp.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On 8/8/07, Nakajima, Jun <jun.nakajima@intel.com> wrote:
> > So, unless I'm very wrong,  it only makes sense to talk about not
> > supporting large pages in the guest level. But it is not a
> > paravirt_ops problem.
>
> Some MMU-related PV techiniques (including Xen, and direct paging mode
> for Xen/KVM) need to write-protect page tables, avoiding to use 2MB
> pages when mapping page tables. Looks like you did not, and that
> exaplains why the patches are missing the relevant (many) paravirt_ops
> in include/asm-x86_64/pgalloc.h, for example, compared with the i386
> tree.
I see.

I'll address this in the next version of the patch.


-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
