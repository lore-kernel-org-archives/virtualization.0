From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: is kexec on Xen domU possible?
Date: Mon, 22 Jul 2013 11:36:10 -0700
Message-ID: <51ED7B9A.1050004@zytor.com>
References: <20130719020603.GA22932@kroah.com>
	<20130719131819.GC11233@debian70-amd64.local.net-space.pl>
	<20130719151243.GA15488@kroah.com>
	<20130719183235.GA12267@debian70-amd64.local.net-space.pl>
	<20130719191449.GA1882@kroah.com> <51E9A85D.2060206@zytor.com>
	<20130722170307.GB14451@debian70-amd64.local.net-space.pl>
	<87wqoise9d.fsf@xmission.com> <51ED78EE.9020903@zytor.com>
	<20130722183315.GA29273@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130722183315.GA29273@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>, Brandon Philips <brandon@ifup.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07/22/2013 11:33 AM, Greg KH wrote:
> 
> I don't care about kdump, I care about kexec on domU for people who are
> running on cloud providers with old versions of Xen so that they can
> control what kernel they can boot, when they want to boot it.  If kdump
> works as well, that's just a bonus, but it's down on the list of things
> for me to be concerned about.
> 

Another valid use case, to be sure.

	-hpa
