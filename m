From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Where does vmi_apply_boot_page_allocations ever get called?
Date: Thu, 01 Mar 2007 01:45:47 -0800
Message-ID: <45E6A0CB.8050405@goop.org>
References: <45E69FAA.7080008@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45E69FAA.7080008@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Because I need a hook for "do stuff after mem_map is valid" too.

Oh, #ifdef CONFIG_DEBUG_PAGE_TYPE.  I was wondering when struct page
grew a "type" field.

    J
