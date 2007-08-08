From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: Introducing paravirt_ops for x86_64
Date: Wed, 8 Aug 2007 11:58:14 -0300
Message-ID: <5d6222a80708080758t1b937d0ej14c5e60ac23a20c5__14117.1727366329$1186585632$gmane$org@mail.gmail.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<97D612E30E1F88419025B06CB4CF1BE10326E129@scsmsx412.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <97D612E30E1F88419025B06CB4CF1BE10326E129@scsmsx412.amr.corp.intel.com>
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
> Glauber de Oliveira Costa wrote:
> > Hi folks,
> >
> > After some time away from it, and a big rebase as a consequence, here
> is
> > the updated version of paravirt_ops for x86_64, heading to inclusion.
> >
> > Your criticism is of course, very welcome.
> >
> > Have fun
>
> Do you assume that the kernel ougtht to use 2MB pages for its mappings
> (e.g. initilal text/data,  direct mapping of physical memory) under your
> paravirt_ops?  As far as I look at the patches, I don't find one.

I don't think how it could be relevant here. lguest kernel does use
2MB pages, and it goes smootly. For 2MB pages, we will update the page
tables in the very same way, and in the very places we did before.
Just that the operations can now be overwritten.

So, unless I'm very wrong,  it only makes sense to talk about not
supporting large pages in the guest level. But it is not a
paravirt_ops problem.


-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
